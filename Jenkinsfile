pipeline {
    agent any

    environment {
        SURNAME         = 'Jain'
    }
    
    stages {
        stage('Build') {
            
    environment {
        DISABLE_AUTH = 'true'
        DB_ENGINE    = 'sqlite'
        NAME         = 'Abhi'
    }
            steps {
                echo "Database engine is ${DB_ENGINE}"
                echo "DISABLE_AUTH is ${DISABLE_AUTH}"
                echo "Name is ${NAME}"
                echo "Surname is ${SURNAME}"
                sh 'cat index.html'
            }
        }
    }
}

//test
