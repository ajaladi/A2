//This file with create a CI/CD pipeline for building and  deploying the dcoker image to k8 cluster using Github as source control version.

pipeline{
    
    environment {
	    	registry = "amulyajaladi/studentsurvey645"
        registryCredential = 'dockerhub'
        def dateTag = new Date().format("yyyyMMdd-HHmmss")
	}
agent any
  stages{
    stage('Building war') {
            steps {
                script {
                    sh 'rm -rf *.war'
                    sh 'jar -cvf swe645_assn2.war -C src/main/webapp .'
                    docker.withRegistry('',registryCredential){
                      def img = docker.build('amulyajaladi/studentsurvey645:'+ dateTag)
                   }
                    
               }
            }
        }
    stage('Pushing latest code to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('',registryCredential) {
                        def image = docker.build('amulyajaladi/studentsurvey645:'+ dateTag, '. --no-cache')
                        docker.withRegistry('',registryCredential) {
                            image.push()
                        }
                    }
                }
            }
        }
     stage('Deploying to single node in Rancher and load Balancer') {
         steps {
            script{
               sh 'kubectl set image deployment/deploy2 container-0=amulyajaladi/studentsurvey645:'+dateTag
               // sh 'kubectl set image deployment/deploylb container-0=amulyajaladi/studentsurvey645:'+dateTag
            }
         }
      }
  }
 
  post {
	  always {
			sh 'docker logout'
		}
	}    
}
