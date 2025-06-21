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

(declare-sort var1441 0)
(declare-sort var3358 0)
(declare-sort var1637 0)
(declare-sort var1069 0)
(declare-sort var3998 0)
(declare-sort var1723 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun serviceToSerializationId/852059633 (var1441) var1637)
(declare-fun var3998_get/1088891777 (var3998 var1069) var1069)
(declare-fun cast-from-var1637-to-var3998 (var1637) var3998)
(declare-fun cast-from-String-to-var1069 (String) var1069)
(declare-fun cast-from-var1069-to-var1723 (var1069) var1723)
(declare-fun var1723_contains/1636690605 (var1723 var1069) Bool)
(declare-fun cast-from-Int-to-var1069 (Int) var1069)
(declare-const null-var1441 var1441)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-var1723 var1723)
(declare-const var2666 var1441) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper 
(assert (not (= var2666 null-var1441)))
(declare-const var3502 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3502 null-String)))
(declare-const var2583 Int) ; Statement: r5 := @parameter1: java.lang.Byte 
(assert (not (= var2583 null-Int)))
(define-const var1612 var1637 (serviceToSerializationId/852059633 var2666)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper: java.util.concurrent.ConcurrentMap serviceToSerializationId> 
(define-const var1386 var1069 (var3998_get/1088891777 (cast-from-var1637-to-var3998 var1612) (cast-from-String-to-var1069 var3502))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var173 var1723 (cast-from-var1069-to-var1723 var1386)) ; Statement: r4 = (java.util.Set) $r3 
 ; Statement: if r4 != null goto $z0 = interfaceinvoke r4.<java.util.Set: boolean contains(java.lang.Object)>(r5) 
(assert (not (= var173 null-var1723))) ; Cond: r4 != null 
(define-const var1404 Bool (var1723_contains/1636690605 var173 (cast-from-Int-to-var1069 var2583))) ; Statement: $z0 = interfaceinvoke r4.<java.util.Set: boolean contains(java.lang.Object)>(r5) 
 ; Statement: return $z0 
(check-sat)
; {serviceToSerializationId/852059633=([org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper], java.util.concurrent.ConcurrentMap), var3998_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1637-to-var3998=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var1069=([java.lang.String], java.lang.Object), cast-from-var1069-to-var1723=([java.lang.Object], java.util.Set), var1723_contains/1636690605=([java.util.Set, java.lang.Object], boolean), cast-from-Int-to-var1069=([java.lang.Byte], java.lang.Object)}
; {var1441=org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper, var2666=r0, var3502=r1, var3358=null_type, var2583=r5, var1637=java.util.concurrent.ConcurrentMap, var1612=$r2, var1069=java.lang.Object, var3998=java.util.Map, var1386=$r3, var1723=java.util.Set, var173=r4, var1404=$z0}
; {org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper=var1441, r0=var2666, r1=var3502, null_type=var3358, r5=var2583, java.util.concurrent.ConcurrentMap=var1637, $r2=var1612, java.lang.Object=var1069, java.util.Map=var3998, $r3=var1386, java.util.Set=var1723, r4=var173, $z0=var1404}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper;	r1 := @parameter0: java.lang.String;	r5 := @parameter1: java.lang.Byte;	$r2 = r0.<org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper: java.util.concurrent.ConcurrentMap serviceToSerializationId>;	$r3 = interfaceinvoke $r2.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r1);	r4 = (java.util.Set) $r3;	if r4 != null goto $z0 = interfaceinvoke r4.<java.util.Set: boolean contains(java.lang.Object)>(r5);	$z0 = interfaceinvoke r4.<java.util.Set: boolean contains(java.lang.Object)>(r5);	return $z0
;block_num 2