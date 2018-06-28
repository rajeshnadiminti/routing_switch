
#ifndef LIBPATHRESOLVER_H
#define LIBPATHRESOLVER_H


#include <assert.h>
#include <stdint.h>
#include <stdio.h>
#include "libtopology.h"
#include "hash_table.h"
#include "doubly_linked_list.h"


typedef struct {
  hash_table *topology_table;
  hash_table *node_table;
} pathresolver;


typedef struct {
  uint64_t dpid;
  uint16_t in_port_no;
  uint16_t out_port_no;
} pathresolver_hop;


dlist_element *resolve_path( pathresolver *table, uint64_t in_dpid, uint16_t in_port,
                             uint64_t out_dpid, uint16_t out_port );
void free_hop_list( dlist_element *hops );
pathresolver *create_pathresolver( void );
bool delete_pathresolver( pathresolver *table );
void update_topology( pathresolver *table, const topology_link_status *s );


#endif	// LIBPATHRESOLVER_H


