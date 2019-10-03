dnasimilarity(a,b)=a!="" ? (a[1]==b[1])+dnasimilarity(a[2:end],b[2:end]) : 0

dnasimilarity(a,b)=count()


println(dnasimilarity("asdf","ssdf"))