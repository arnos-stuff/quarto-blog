module ArnosJuliaSnippets
using DataFrames, ZipFile, CSV, Plots
export processZip, extractFilesZip, linSpace, diracPlot 

    function processZip(zip::ZipFile.ReadableFile)

        if split(zip.name,".")[end] == "zip"

            iobuffer = IOBuffer(readstring(zip))
            r = ZipFile.Reader(iobuffer)

            for f in r.files
                processZip(f) 
            end
        end

        if split(zip.name,".")[end] == "csv"
            df = readtable(zip) #for now just read it into a dataframe
        end

    end

    function extractFilesZip(zip::ZipFile.ReadableFile)

        r = ZipFile.Reader(zip);

        for f in r.files
            processZip(f)
        end
        close(r)
    end

    function linSpace(start::Any, stop::Any, n::Int)
        step = (stop - start) / (n - 1)
        return start:step:stop
    end

    function diracPlot(x::Any, y::Any, label::Any = "")
        plot!([x,0],[x,y],arrow=true,linewidth=2, label=label)
    end
end