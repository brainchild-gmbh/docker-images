$url="$env:JENKINS_MASTER_URL"
$user="$env:JENKINS_USER"
$password="$env:JENKINS_PASSWORD"

echo "Download Jenkins agent from $url ..."
wget "$url/jnlpJars/agent.jar" -OutFile agent.jar

echo "Run Jenkins agent ..."
java -jar agent.jar -jnlpCredentials "$user"":""$password" -jnlpUrl "$url/computer/windows_slave/slave-agent.jnlp"
