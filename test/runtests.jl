using Quadratic, Test

function getprintoutput(a, b, c)
    out = IOBuffer()
    printquadratic(out, a, b, c)
    String(take!(out))
end

function testquadraticfunctions()
    a,b,c = -4.0,2.0,8.5
    x = 3.0
    expected = -21.5
    @test quadratic(x, a, b, c)  == expected

    a,b,c = 208.5,0,-35.0
    x = -0.02
    expected = -34.9166
    @test quadratic(x, a, b, c)  == expected

    a,b,c = 5.5,0.1,3000
    x = -10
    expected = 3549
    @test quadratic(x, a, b, c)  == expected

    a,b,c = 0,7.5,1.5
    x = 3
    expected = 24
    @test quadratic(x, a, b, c)  == expected

    a,b,c = 0,0,-9048.893
    x = -567.89
    expected = -9048.893
    @test quadratic(x, a, b, c)  == expected


    a,b,c = 40.0,-2.5,17.0
    f = quadraticfunction(a, b, c)

    x = -30
    expected = 36092
    @test f(x) == expected

    x = 0
    expected = 17
    @test f(x) == expected

    x = 4.5
    expected = 815.75
    @test f(x) == expected


    a,b,c = -3.5,0,1.2
    f = quadraticfunction(a, b, c)

    x = -10
    expected = -348.8
    @test f(x) == expected

    x = 0
    expected = 1.2
    @test f(x) == expected

    x = 2.5
    expected = -20.675
    @test f(x) == expected
end

function testroots(actualroots, root1, root2; shouldagree)
    roots = QuadraticRoots(root1, root2)
    @test isnear(actualroots, roots)  == shouldagree
    @test isnear(roots, actualroots)  == shouldagree

    roots = QuadraticRoots(root2, root1)
    @test isnear(actualroots, roots)  == shouldagree
    @test isnear(roots, actualroots)  == shouldagree
end

function testroot(actualroot, rootval; shouldagree)
    root = QuadraticRoot(rootval)
    @test isnear(actualroot, root)  == shouldagree
    @test isnear(root, actualroot)  == shouldagree
end


function testrootsandvertex()
    # 2 real roots.
    a,b,c = 2.0,5.0,-1.0
    actual = getroots(a, b, c)

    expected1 = 0.18614066163451
    expected2 = -2.6861406616345
    testroots(actual, expected1, expected2; shouldagree=true)

    notexpected1 = 0.20614066163451
    notexpected2 = -2.9861406616345
    testroots(actual, notexpected1, notexpected2; shouldagree=false)

    @test getvertex(a,b,c) == (x=-1.25, y=-4.125)


    # 2 complex roots.
    a,b,c = -2.5,0.1,-2
    actual = getroots(a, b, c)

    expected1 = 0.02 + 0.89420355624433im
    expected2 = 0.02 - 0.89420355624433im
    testroots(actual, expected1, expected2; shouldagree=true)

    notexpected1 = 0.012677613858205 + 0.021379088842857im
    notexpected2 = 0.012677613858205 - 0.021379088842857im
    testroots(actual, notexpected1, notexpected2; shouldagree=false)

    @test getvertex(a,b,c) == (x=0.02, y=-1.999)


    # 1 real root.
    a,b,c = -40,30,-5.625
    actual = getroots(a, b, c)

    expected = 0.375
    testroot(actual, expected; shouldagree=true)

    notexpected = -0.375
    testroot(actual, notexpected; shouldagree=false)

    @test getvertex(a,b,c) == (x=0.375, y=0)
end

function testprintquadratic()
    a,b,c = 2,5.2,-1
    expected = """ax^2+bx+c where a=2, b=5.2, c=-1:
        Roots are 0.17986486 and -2.7798649
        Vertex (point where y is at a minimum): (x=-1.3,y=-4.38)
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = -2,5,0
    expected = """ax^2+bx+c where a=-2, b=5, c=0:
        Roots are 0 and 2.5
        Vertex (point where y is at a maximum): (x=1.25,y=3.125)
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = 3.01,0,1.4
    expected = """ax^2+bx+c where a=3.01, b=0, c=1.4:
        Roots are (0 + 0.68199434i) and (0 - 0.68199434i)
        Vertex (point where y is at a minimum): (x=0,y=1.4)
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = 2,5,3.125
    expected = """ax^2+bx+c where a=2, b=5, c=3.125:
        Root is -1.25
        Vertex (point where y is at a minimum): (x=-1.25,y=0)
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = -8093.4,205.21,-10
    expected = """ax^2+bx+c where a=-8093.4, b=205.21, c=-10:
        Roots are (0.01268 + 0.03278i) and (0.01268 - 0.03278i)
        Vertex (point where y is at a maximum): (x=-0.0127,y=-8.6992)
    """

    a,b,c = -40,30,-5.625
    expected = """ax^2+bx+c where a=-40, b=30, c=-5.625:
        Root is 0.375
        Vertex (point where y is at a maximum): (x=0.375,y=0)
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = 0,9.2,1
    expected = """ax^2+bx+c where a=0, b=9.2, c=1:
        Function is linear with intercept (x where y=0) -0.10869565
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = 0,3458.95,-45
    expected = """ax^2+bx+c where a=0, b=3458.95, c=-45:
        Function is linear with intercept (x where y=0) 0.013009728
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = 0,1.2,0
    expected = """ax^2+bx+c where a=0, b=1.2, c=0:
        Function is linear with intercept (x where y=0) 0
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = 0,-5,649
    expected = """ax^2+bx+c where a=0, b=-5, c=649:
        Function is linear with intercept (x where y=0) 129.8
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = 0,-0.021,-10
    expected = """ax^2+bx+c where a=0, b=-0.021, c=-10:
        Function is linear with intercept (x where y=0) -476.19048
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = 0,-437,0
    expected = """ax^2+bx+c where a=0, b=-437, c=0:
        Function is linear with intercept (x where y=0) 0
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = 0,0,1
    expected = """ax^2+bx+c where a=0, b=0, c=1:
        Function has constant value 1
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = 0,0,-39.7
    expected = """ax^2+bx+c where a=0, b=0, c=-39.7:
        Function has constant value -39.7
    """
    @test getprintoutput(a, b, c) == expected

    a,b,c = 0,0,0
    expected = """ax^2+bx+c where a=0, b=0, c=0:
        Function has constant value 0
    """
    @test getprintoutput(a, b, c) == expected


end

@testset "Quadratic" begin
    testquadraticfunctions()
    testrootsandvertex()
    testprintquadratic()
end
