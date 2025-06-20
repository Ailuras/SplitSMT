(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var127 0)
(declare-sort var3905 0)
(declare-sort var2484 0)
(declare-sort var2939 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2484_getExtension/1417313418 (var3905) var2484)
(declare-fun var2484_providerKey/1441539650 (var2484 var3905) String)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(declare-const null-var127 var127)
(declare-const null-var3905 var3905)
(declare-const null-String String)
(declare-const var1109 var127) ; Statement: r2 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceNameMapping 
(assert (not (= var1109 null-var127)))
(declare-const var1581 var3905) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1581 null-var3905)))
(define-const var2418 var2484 (var2484_getExtension/1417313418 var1581)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.registry.client.RegistryClusterIdentifier: org.apache.dubbo.registry.client.RegistryClusterIdentifier getExtension(org.apache.dubbo.common.URL)>(r0) 
(define-const var2367 String (var2484_providerKey/1441539650 var2418 var1581)) ; Statement: r3 = interfaceinvoke $r1.<org.apache.dubbo.registry.client.RegistryClusterIdentifier: java.lang.String providerKey(org.apache.dubbo.common.URL)>(r0) 
 ; Statement: if r3 != null goto $i0 = virtualinvoke r3.<java.lang.String: int indexOf(java.lang.String)>(",") 
(assert (not (= var2367 null-String))) ; Cond: r3 != null 
(assert true)
(define-const var1390 Int (indexOf/-1209756239 var2367 ",")) ; Statement: $i0 = virtualinvoke r3.<java.lang.String: int indexOf(java.lang.String)>(",") 
 ; Statement: if $i0 <= 0 goto return r3 
(assert (<= var1390 0)) ; Cond: $i0 <= 0 
 ; Statement: return r3 
(check-sat)
; {var2484_getExtension/1417313418=([org.apache.dubbo.common.URL], org.apache.dubbo.registry.client.RegistryClusterIdentifier), var2484_providerKey/1441539650=([org.apache.dubbo.registry.client.RegistryClusterIdentifier, org.apache.dubbo.common.URL], java.lang.String), indexOf/-1209756239=([java.lang.String, java.lang.String], int)}
; {var127=org.apache.dubbo.registry.client.metadata.MetadataServiceNameMapping, var1109=r2, var3905=org.apache.dubbo.common.URL, var1581=r0, var2484=org.apache.dubbo.registry.client.RegistryClusterIdentifier, var2418=$r1, var2367=r3, var2939=null_type, var1390=$i0}
; {org.apache.dubbo.registry.client.metadata.MetadataServiceNameMapping=var127, r2=var1109, org.apache.dubbo.common.URL=var3905, r0=var1581, org.apache.dubbo.registry.client.RegistryClusterIdentifier=var2484, $r1=var2418, r3=var2367, null_type=var2939, $i0=var1390}
;seq <java.lang.String: int indexOf(java.lang.String)>
;cnt {"<java.lang.String: int indexOf(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceNameMapping;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r1 = staticinvoke <org.apache.dubbo.registry.client.RegistryClusterIdentifier: org.apache.dubbo.registry.client.RegistryClusterIdentifier getExtension(org.apache.dubbo.common.URL)>(r0);	r3 = interfaceinvoke $r1.<org.apache.dubbo.registry.client.RegistryClusterIdentifier: java.lang.String providerKey(org.apache.dubbo.common.URL)>(r0);	if r3 != null goto $i0 = virtualinvoke r3.<java.lang.String: int indexOf(java.lang.String)>(",");	$i0 = virtualinvoke r3.<java.lang.String: int indexOf(java.lang.String)>(",");	if $i0 <= 0 goto return r3;	return r3
;block_num 3