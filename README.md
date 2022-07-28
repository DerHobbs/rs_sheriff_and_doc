# rs_sheriff_and_doc
Simple sheriff and doctor job with the most important functions

Since every existing script was missing something or far too much, I put together one that fully meets my needs. <br>
## Credits <br> 
to everyone else who has published similar scripts! #VORPCORE

## Job description <br>
<br>
*Sheriff* <br>
-Sheriff badge on and off <br>
-Handcuffs on and off <br>
-Escort a person <br>
<br>
Todo: Put the handcuffed player in the jail car <br>
<br>
*Doctor* <br>
-Player heal<br>
-Revive player<br>

## How to Install? <br> 
1. Copy the Folder into your resources/ folder <br> 
2. Add `rs_sheriff_and_doc` to your server.cfg <br> 

## Dependencies

* [menuapi](https://github.com/outsider31000/menuapi)

## If you use syn_society <br> 
If you can add this to both server sides, then the menu will only open if the corresponding job is on duty. <br>

```if exports["syn_society"]:IsPlayerOnDuty(_source,job) == true then``` <br>

![Screenshot_5](https://user-images.githubusercontent.com/101003021/181524385-a5d85a2b-2bcd-49ff-8f0c-0c87e807daeb.png)

