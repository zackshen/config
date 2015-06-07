#!/bin/bash


install_mutt() {


echo "
# Folder hooks
folder-hook 'account.gmail.user_xxx' 'source ~/.mutt/account.gmail.user_xxx'
folder-hook 'account.exchange.user_yyy' 'source ~/.mutt/account.exchange.user_yyy'

# Default account
source ~/.mutt/account.gmail.user_xxx
macro index <F1> '<sync-mailbox><enter-command>source ~/.mutt/account.gmail.user_xxx<enter><change-folder>!<enter>'
macro index <F2> '<sync-mailbox><enter-command>source ~/.mutt/account.exchange.user_yyy<enter><change-folder>!<enter>'

# Key binding
## ==============
## Key binding for index
## ==============
bind index \Cu   previous-page
bind index \Cd   next-page
 
## ==============
## Key binding for pager
## ==============
bind pager \Cj   next-line         
bind pager \Ck   previous-line 
bind pager gg    top
bind pager G     bottom

set editor = "$EDITOR"
set sort = 'threads'
set sort_aux = 'reverse-last-date-received'
ignore "Authentication-Results:"
ignore "DomainKey-Signature:"
ignore "DKIM-Signature:"
hdr_order Date From To Cc
alternative_order text/plain text/html *
auto_view text/html
bind editor <Tab> complete-query
bind editor ^T complete
bind editor <space> noop 
" >> ${config_dir}"/mutt/muttrc"

echo "

set imap_user = 'user_xxx@gmail.com'
set imap_pass = \`gpg -q --no-tty -d ~/.mutt/gmail.gpg | awk '/passwd:/ {print $2}'\`
set from = 'user_xxx@gmail.com'                            
set realname = 'Zack Shen'                                  
set folder = 'imaps://imap.gmail.com:993'                     
set spoolfile = '+INBOX'                                      
set postponed = '+[Gmail]/Drafts'
set header_cache = ~/.mutt/com.gmail.user_xxx/cache/headers
set message_cachedir = ~/.mutt/com.gmail.user_xxx/cache/bodies
set certificate_file = ~/.mutt/com.gmail.user_xxx/certificates
set timeout = 10
set sendmail = '/usr/local/bin/msmtp -a gmail'
#set smtp_url = 'smtp://user_xxx@smtp.gmail.com:587/'       
#set smtp_pass = \`gpg -q --no-tty -d ~/.mutt/gmail.gpg | awk '/passwd:/ {print $2}'\`
#set smtp_authenticators = 'gssapi:login'

" >> ${config_dir}"/mutt/account.gmail.user_xxx"


echo "

# start davmail server before launch mutt
set from = "user_yyy@exchange.com.cn"
set realname = "user_yyy"
set imap_user = "user_yyy@exchange.com.cn"
set imap_pass = \`gpg -q --no-tty -d ~/.mutt/exchange.gpg | awk '/passwd:/ {print $2}'\`
set smtp_user = "user_yyy@exchange.com.cn"
set smtp_pass = \`gpg -q --no-tty -d ~/.mutt/exchange.gpg | awk '/passed:/ {print $2}'\`
set smtp_url = "smtp://localhost:1025"       
set folder = "imap://localhost:1143"
set spoolfile = "+INBOX"
set header_cache=~/.mutt/cache/headers
set message_cachedir=~/.mutt/cache/bodies
set certificate_file =~/.mutt/certificates
set sendmail="/usr/local/bin/msmtp -a exchange"
set timeout=10

" >> ${config_dir}"/mutt/account.exchange.user_yyy"



echo "

account gmail
host smtp.gmail.com
port 587
tls on
tls_starttls on
tls_trust_file /usr/local/Cellar/mutt/1.5.23_2/share/doc/mutt/samples/ca-bundle.crt
logfile ~/.mutt/msmtp.log
from user_xxx@gmail.com
auth on
user user_xxx@gmail.com
passwordeval gpg -q --no-tty -d ~/.mutt/gmail.gpg | awk '/passwd:/ {print $2}'


account exchange
host 127.0.0.1
port 1025
tls on
logfile ~/.mutt/msmtp.log
from user_yyy@exchange.com.cn
auth on
user user_yyy@exchange.com.cn
passwordeval gpg -q --no-tty -d ~/.mutt/exchange.gpg | awk '/passwd:/ {print $2}'

" >> ${config_dir}"/mutt/msmtprc"

mv ~/.muttrc ~/.muttrc_bak
mv ~/.mutt ~/.mutt_bak

ln -s ${config_dir}"/mutt/muttrc" ~/.muttrc
ln -s ${config_dir}"/mutt" ~/.mutt

}

install_mutt
