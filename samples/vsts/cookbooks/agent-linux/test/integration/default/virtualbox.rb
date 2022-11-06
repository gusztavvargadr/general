describe command('vboxmanage --version') do
  its('stdout') { should include '6.1.' }
end
