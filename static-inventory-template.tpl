[web]
%{ for ip in ubuntu ~}
${ip}
%{ endfor ~}
