// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ShareContract {
    struct Division {
        string name;
    }

    struct Province {
        string name;
        Division[] divisions;
    }

    Province[] public provinces;

    constructor() {
        // Initialize provinces and divisions
        provinces.push();
        provinces[0].name = "Rift Valley";
        provinces[0].divisions.push(Division("Olerei"));
        provinces[0].divisions.push(Division("Ghumbasi"));

        provinces.push();
        provinces[1].name = "Coastal";
        provinces[1].divisions.push(Division("Lwandane"));
        provinces[1].divisions.push(Division("Tarri"));

        // Add more provinces and divisions as needed
    }

    function getProvinces() public view returns (Province[] memory) {
        return provinces;
    }
}
