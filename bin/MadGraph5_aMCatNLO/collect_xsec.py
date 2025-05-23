import json
from itertools import product

PROCESS_LIST = ["DY0j_LO_5f", "DY1j_LO_5f", "DY2j_LO_5f", "DY3j_LO_5f",
                "W0j_LO_5f", "W1j_LO_5f", "W2j_LO_5f", "W3j_LO_5f"]
BACKEND_LIST = ["LEGACY", "UPSTREAM", "FORTRAN", "CPPNONE", "CPPAVX2"]

def collect_xsec(process, backend):
    with open(f"{process}_{backend}.log", "r") as f:
        for line in f:
            if "Cross-section" in line:
                parts = line.split(":")
                if len(parts) > 1:
                    xsec_part = parts[1].strip()
                    xsec_parts = xsec_part.split("+-")
                    if len(xsec_parts) > 1:
                        xsec = float(xsec_parts[0].strip())
                        xsec_err = float(xsec_parts[1].split()[0].strip())
                        return xsec, xsec_err
    return 0.0, 0.0

if __name__ == "__main__":
    output = {}
    for process, backend in product(PROCESS_LIST, BACKEND_LIST):
        xsec, xsec_err = collect_xsec(process, backend)
        output[f"{process}_{backend}"] = {
            "gridpack": [xsec, xsec_err]
        }
    with open("XsecSummary.json", "w") as f:
        json.dump(output, f, indent=4)
