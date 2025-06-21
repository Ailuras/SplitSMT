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

(declare-sort var2414 0)
(declare-sort var626 0)
(declare-sort var712 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun type/-1504388831 (var2414) ClassObject)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun service/-1504388831 (var2414) var626)
(declare-fun var712_identityHashCode/1096208673 (var626) Int)
(declare-fun Int_toHexString/1865784998 (Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2414 var2414)
(declare-const var2606 var2414) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta 
(assert (not (= var2606 null-var2414)))
(define-const var3004 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3004)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3004!1 String)
(assert (= var3004!1 ""))
(define-const var2297 ClassObject (type/-1504388831 var2606)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.Class type> 
(assert true)
(define-const var2738 String (getSimpleName/-390194377 var2297)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getSimpleName()>() 
(assert true)
(define-const var2474 String (append/672562846 var3004!1 var2738)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3004!2 String)
(assert (= var3004!2 (str.++ var3004!1 var2738)))
(assert true)
(define-const var2621 String (append/-1166366385 var2474 64)) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(64) 
(declare-const var2474!1 String)
(assert (str.prefixof var2474 var2474!1))
(define-const var1153 var626 (service/-1504388831 var2606)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.Object service> 
(define-const var870 Int (var712_identityHashCode/1096208673 var1153)) ; Statement: $i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>($r5) 
(define-const var3477 String (Int_toHexString/1865784998 var870)) ; Statement: $r6 = staticinvoke <java.lang.Integer: java.lang.String toHexString(int)>($i0) 
(assert true)
(define-const var3998 String (append/672562846 var2621 var3477)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2621!1 String)
(assert (= var2621!1 (str.++ var2621 var3477)))
(assert true)
(define-const var3326 String (toString/-2075883882 var3998)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), type/-1504388831=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta], java.lang.Class), getSimpleName/-390194377=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), service/-1504388831=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta], java.lang.Object), var712_identityHashCode/1096208673=([java.lang.Object], int), Int_toHexString/1865784998=([int], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2414=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta, var2606=r1, var3004=$r0, var2297=$r2, var2738=$r3, var2474=$r4, var2621=$r7, var626=java.lang.Object, var1153=$r5, var712=java.lang.System, var870=$i0, var3477=$r6, var3998=$r8, var3326=$r9}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta=var2414, r1=var2606, $r0=var3004, $r2=var2297, $r3=var2738, $r4=var2474, $r7=var2621, java.lang.Object=var626, $r5=var1153, java.lang.System=var712, $i0=var870, $r6=var3477, $r8=var3998, $r9=var3326}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.Class type>;	$r3 = virtualinvoke $r2.<java.lang.Class: java.lang.String getSimpleName()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(64);	$r5 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ServiceMeta: java.lang.Object service>;	$i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>($r5);	$r6 = staticinvoke <java.lang.Integer: java.lang.String toHexString(int)>($i0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1