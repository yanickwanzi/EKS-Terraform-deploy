# Learn Terraform - Provision an EKS Cluster

This repo is a companion repo to the [Provision an EKS Cluster tutorial](https://developer.hashicorp.com/terraform/tutorials/kubernetes/eks), containing
Terraform configuration files to provision an EKS cluster on AWS.







pipeline {
    agent { node { label 'terraform-node' } } 
    parameters {
                choice(name: 'deploy_choice', choices:['apply','destroy'],description:'The deployment type')
                  }
    environment {
        EMAIL_TO = 'fusisoft@gmail.com'
    }
    stages {
        stage('1.Terraform init') {
            steps {
                echo 'terraform init phase'
                sh 'terraform init'
            }
        }
        stage('2.Terraform plan') {
            steps {
                echo 'terraform plan phase'
                sh 'AWS_REGION=us-west-2 terraform plan'
            }
        }
        stage('3.Manual Approval') {
            input {
                message "Should we proceed?"
                ok "Yes, we should."
                parameters{
                    choice (name: 'Manual_Approval', choices: ['Approve','Reject'], description: 'Approve or Reject the deployment')
                }
            }
             steps {
                echo "Deployment ${Manual_Approval}"
            }          
        }
        stage('4.Terraform Deploy') {              
            steps { 
                echo 'Terraform ${params.deploy_choice} phase'  
                sh "AWS_REGION=us-west-2 terraform ${params.deploy_choice}  -target=module.vpc -target=module.eks --auto-approve"
                 script {
                    aws eks list-clusters --region us-west-2 --output text 2>&1
                    if  [ $? != 0 ]
                    then
                        echo "dominion-cluster does not exist"
                    else
                        echo "updating cluster kubeconfig file "
                        aws eks --region us-west-2 update-kubeconfig --name dominion-cluster && export KUBE_CONFIG_PATH=~/.kube/conf
                    fi
                }
                sh "AWS_REGION=us-west-2 terraform ${params.deploy_choice} --auto-approve"
            }
                }
        stage ('5. Email Notification') {
            steps {
               mail bcc: 'fusisoft@gmail.com', body: '''Terraform deployment is completed.
               Let me know if the changes look okay.
               Thanks,
               Dominion System Technologies,
              +1 (313) 413-1477''', cc: 'fusisoft@gmail.com', from: '', replyTo: '', subject: 'Terraform Infra deployment completed!!!', to: 'fusisoft@gmail.com'
                          
               }    
          }
     }       
}  

