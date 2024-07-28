module.exports = {
    networks: {
      development: {
        provider: 'http://localhost:8545',
        network_id: 5777,
      },
    },
    compilers: {
      solc: {
        version: '0.8.0',
      },
    },
  };