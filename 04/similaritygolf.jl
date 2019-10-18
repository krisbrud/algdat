# d(a,b)=a>""&&(a[1]==b[1])+d(a[2:end],b[2:end])

# dnasimilarity(a,b)=count(x->x==0,[a...]-[b...])
# dnasimilarity(a,b)=count(iszero,[a...]-[b...])
dnasimilarity(a,b)=sum([a...]-[b...].==0)

# dnasimilarity(a,b)=[a...]-[b...]

println(dnasimilarity("asdf", "ssdf"))
# println(dnasimilarity("",""))
println(dnasimilarity("as","sa"))

# println(dnasimilarity("asdf","ssdf"))