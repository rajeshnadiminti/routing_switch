
#ifndef FDB_H
#define FDB_H


#include "trema.h"


hash_table *create_fdb( void );
bool is_ether_multicast( const uint8_t mac[ OFP_ETH_ALEN ] );
void delete_fdb( hash_table *fdb );
bool update_fdb( hash_table *fdb, const uint8_t mac[ OFP_ETH_ALEN ], uint64_t dpid, uint16_t port );
bool lookup_fdb( hash_table *fdb, const uint8_t mac[ OFP_ETH_ALEN ], uint64_t *dpid, uint16_t *port );
void init_age_fdb( hash_table *fdb );
void delete_fdb_entries( hash_table *fdb, uint64_t dpid, uint16_t port );


#endif // FDB_H

