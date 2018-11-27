### commit without add

`$git commit -m "comment"`

On branch master
Your branch is up to date with 'origin/master'.

Changes not staged for commit:
	modified:   NavCtrl_Swift/NavCtrl_Swift/Company.swift

**no changes added to commit**

### commit after add

`$git add .`

`$git commit -m "comment"`

[master 6041acb] comment
....

### pushing new branch

`$git push --set-upstream origin branch_name`

`$git push`


## merge to master

`$git checkout master`


`$git pull`

`$git merge -X theirs branch`

`$git push`



