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

(declare-sort var1124 0)
(declare-sort var754 0)
(declare-sort var2647 0)
(declare-sort var1850 0)
(declare-sort var3615 0)
(declare-sort var682 0)
(declare-sort var994 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun serviceToSerializationId/852059633 (var1124) var2647)
(declare-fun var3615_get/1088891777 (var3615 var1850) var1850)
(declare-fun cast-from-var2647-to-var3615 (var2647) var3615)
(declare-fun cast-from-String-to-var1850 (String) var1850)
(declare-fun cast-from-var1850-to-var682 (var1850) var682)
(declare-fun var994-init () var994)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1557872005 (var994 String) void)
(declare-const null-var1124 var1124)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-var682 var682)
(declare-const var2863 var1124) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper 
(assert (not (= var2863 null-var1124)))
(declare-const var2263 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2263 null-String)))
(declare-const var1660 Int) ; Statement: r5 := @parameter1: java.lang.Byte 
(assert (not (= var1660 null-Int)))
(define-const var3009 var2647 (serviceToSerializationId/852059633 var2863)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper: java.util.concurrent.ConcurrentMap serviceToSerializationId> 
(define-const var91 var1850 (var3615_get/1088891777 (cast-from-var2647-to-var3615 var3009) (cast-from-String-to-var1850 var2263))) ; Statement: $r3 = interfaceinvoke $r2.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r1) 
(define-const var3346 var682 (cast-from-var1850-to-var682 var91)) ; Statement: r4 = (java.util.Set) $r3 
 ; Statement: if r4 != null goto $z0 = interfaceinvoke r4.<java.util.Set: boolean contains(java.lang.Object)>(r5) 
(assert (not (not (= var3346 null-var682)))) ; Negate: Cond: r4 != null  
(define-const var77 var994 var994-init) ; Statement: $r6 = new java.io.IOException 
(define-const var2726 String String-init) ; Statement: $r7 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2726)) ; Statement: specialinvoke $r7.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2726!1 String)
(assert (= var2726!1 ""))
(assert true)
(define-const var3317 String (append/672562846 var2726!1 "Service ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Service ") 
(declare-const var2726!2 String)
(assert (= var2726!2 (str.++ var2726!1 "Service ")))
(assert true)
(define-const var3090 String (append/672562846 var3317 var2263)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3317!1 String)
(assert (= var3317!1 (str.++ var3317 var2263)))
(assert true)
(define-const var420 String (append/672562846 var3090 " not found, invocation rejected.")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" not found, invocation rejected.") 
(declare-const var3090!1 String)
(assert (= var3090!1 (str.++ var3090 " not found, invocation rejected.")))
(assert true)
(define-const var2403 String (toString/-2075883882 var420)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1557872005 var77 var2403)) ; Statement: specialinvoke $r6.<java.io.IOException: void <init>(java.lang.String)>($r11) 

(declare-const var77!1 var994)
(declare-const var2403!1 String)
 ; Statement: throw $r6 
(check-sat)
; {serviceToSerializationId/852059633=([org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper], java.util.concurrent.ConcurrentMap), var3615_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var2647-to-var3615=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var1850=([java.lang.String], java.lang.Object), cast-from-var1850-to-var682=([java.lang.Object], java.util.Set), var994-init=([], java.io.IOException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1557872005=([java.io.IOException, java.lang.String], void)}
; {var1124=org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper, var2863=r0, var2263=r1, var754=null_type, var1660=r5, var2647=java.util.concurrent.ConcurrentMap, var3009=$r2, var1850=java.lang.Object, var3615=java.util.Map, var91=$r3, var682=java.util.Set, var3346=r4, var994=java.io.IOException, var77=$r6, var2726=$r7, var3317=$r8, var3090=$r9, var420=$r10, var2403=$r11}
; {org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper=var1124, r0=var2863, r1=var2263, null_type=var754, r5=var1660, java.util.concurrent.ConcurrentMap=var2647, $r2=var3009, java.lang.Object=var1850, java.util.Map=var3615, $r3=var91, java.util.Set=var682, r4=var3346, java.io.IOException=var994, $r6=var77, $r7=var2726, $r8=var3317, $r9=var3090, $r10=var420, $r11=var2403}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper;	r1 := @parameter0: java.lang.String;	r5 := @parameter1: java.lang.Byte;	$r2 = r0.<org.apache.dubbo.rpc.protocol.PermittedSerializationKeeper: java.util.concurrent.ConcurrentMap serviceToSerializationId>;	$r3 = interfaceinvoke $r2.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>(r1);	r4 = (java.util.Set) $r3;	if r4 != null goto $z0 = interfaceinvoke r4.<java.util.Set: boolean contains(java.lang.Object)>(r5);	$r6 = new java.io.IOException;	$r7 = new java.lang.StringBuilder;	specialinvoke $r7.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Service ");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" not found, invocation rejected.");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r6.<java.io.IOException: void <init>(java.lang.String)>($r11);	throw $r6
;block_num 2