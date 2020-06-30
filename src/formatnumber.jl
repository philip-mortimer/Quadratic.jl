using Printf

function formatnumber(x::Real; round=true)
    if nearzero(x)
        return "0"
    end

    if round
        str = @sprintf "%.8g" x;
    else
        str = "$x"
    end
    str
end

function formatnumber(z::Complex; round=true)
    i = imag(z)
    sign = i < 0 ? '-' : '+'

    rstr = formatnumber(real(z); round=round)
    istr = formatnumber(abs(i); round=round)

    "($rstr $sign $(istr)i)"
end

function formatpoint(point; round=true)
    xstr = formatnumber(point.x; round=round)
    ystr = formatnumber(point.y; round=round)

    "(x=$xstr,y=$ystr)"
end
