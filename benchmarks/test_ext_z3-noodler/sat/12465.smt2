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

(declare-sort var2316 0)
(declare-sort var529 0)
(declare-sort var1114 0)
(declare-sort var1146 0)
(declare-sort var3254 0)
(declare-sort var399 0)
(declare-sort var1253 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getServiceKey/-892672314 (var1114) String)
(declare-fun cast-from-var529-to-var1114 (var529) var1114)
(declare-fun var1146_identityHashCode/1096208673 (var3254) Int)
(declare-fun cast-from-var529-to-var3254 (var529) var3254)
(declare-fun Int_toHexString/1865784998 (Int) String)
(declare-fun var399-init () var399)
(declare-fun <init>/-201242697 (var399) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var2316_put/1464166817 (var2316 var3254 var3254) var3254)
(declare-fun cast-from-String-to-var3254 (String) var3254)
(declare-fun cast-from-var399-to-var3254 (var399) var3254)
(declare-fun getServiceMetadata/703324177 (var1114) var1253)
(declare-fun getAttribute/-355102655 (var1253 String) var3254)
(declare-const null-String String)
(declare-const null-var2316 var2316)
(declare-const null-var529 var529)
(declare-const var2023 String) ; Statement: r0 := @parameter0: java.lang.StringBuilder 
(assert (not (= var2023 null-String)))
(declare-const var2418 var2316) ; Statement: r9 := @parameter1: java.util.Map 
(assert (not (= var2418 null-var2316)))
(declare-const var1452 var529) ; Statement: r1 := @parameter2: org.apache.dubbo.rpc.model.ConsumerModel 
(assert (not (= var1452 null-var529)))
(assert true)
(define-const var776 String (append/672562846 var2023 "ConsumerModel: ")) ; Statement: $r3 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ConsumerModel: ") 
(declare-const var2023!1 String)
(assert (= var2023!1 (str.++ var2023 "ConsumerModel: ")))
(assert true)
(define-const var9 String (getServiceKey/-892672314 (cast-from-var529-to-var1114 var1452))) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ConsumerModel: java.lang.String getServiceKey()>() 
(assert true)
(define-const var2 String (append/672562846 var776 var9)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var776!1 String)
(assert (= var776!1 (str.++ var776 var9)))
(assert true)
(define-const var1624 String (append/672562846 var2 "@")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("@") 
(declare-const var2!1 String)
(assert (= var2!1 (str.++ var2 "@")))
(define-const var1478 Int (var1146_identityHashCode/1096208673 (cast-from-var529-to-var3254 var1452))) ; Statement: $i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r1) 
(define-const var2024 String (Int_toHexString/1865784998 var1478)) ; Statement: $r5 = staticinvoke <java.lang.Integer: java.lang.String toHexString(int)>($i0) 
(assert true)
(define-const var679 String (append/672562846 var1624 var2024)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var1624!1 String)
(assert (= var1624!1 (str.++ var1624 var2024)))
(assert true)
;(assert (append/672562846 var679 "\n\n")) ; Statement: virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\n") 
(declare-const var679!1 String)
(assert (= var679!1 (str.++ var679 "\n\n")))
(define-const var395 var399 var399-init) ; Statement: $r8 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var395)) ; Statement: specialinvoke $r8.<java.util.HashMap: void <init>()>() 

(declare-const var395!1 var399)
(define-const var3656 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3656)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3656!1 String)
(assert (= var3656!1 ""))
(assert true)
(define-const var842 String (getServiceKey/-892672314 (cast-from-var529-to-var1114 var1452))) ; Statement: $r11 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ConsumerModel: java.lang.String getServiceKey()>() 
(assert true)
(define-const var37 String (append/672562846 var3656!1 var842)) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11) 
(declare-const var3656!2 String)
(assert (= var3656!2 (str.++ var3656!1 var842)))
(assert true)
(define-const var3021 String (append/672562846 var37 "@")) ; Statement: $r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("@") 
(declare-const var37!1 String)
(assert (= var37!1 (str.++ var37 "@")))
(define-const var1261 Int (var1146_identityHashCode/1096208673 (cast-from-var529-to-var3254 var1452))) ; Statement: $i1 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r1) 
(define-const var310 String (Int_toHexString/1865784998 var1261)) ; Statement: $r13 = staticinvoke <java.lang.Integer: java.lang.String toHexString(int)>($i1) 
(assert true)
(define-const var2639 String (append/672562846 var3021 var310)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var3021!1 String)
(assert (= var3021!1 (str.++ var3021 var310)))
(assert true)
(define-const var2525 String (toString/-2075883882 var2639)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var2316_put/1464166817 var2418 (cast-from-String-to-var3254 var2525) (cast-from-var399-to-var3254 var395!1))) ; Statement: interfaceinvoke r9.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r16, $r8) 

(declare-const var2418!1 var2316)
(declare-const var2525!1 String)
(declare-const var395!2 var399)
(assert true)
(define-const var1135 var1253 (getServiceMetadata/703324177 (cast-from-var529-to-var1114 var1452))) ; Statement: $r17 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceMetadata getServiceMetadata()>() 
(assert true)
(define-const var1937 var3254 (getAttribute/-355102655 var1135 "currentClusterInvoker")) ; Statement: r18 = virtualinvoke $r17.<org.apache.dubbo.rpc.model.ServiceMetadata: java.lang.Object getAttribute(java.lang.String)>("currentClusterInvoker") 
(define-const var596 Bool false) ; Statement: $z0 = r18 instanceof java.util.Map 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var596 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getServiceKey/-892672314=([org.apache.dubbo.rpc.model.ServiceModel], java.lang.String), cast-from-var529-to-var1114=([org.apache.dubbo.rpc.model.ConsumerModel], org.apache.dubbo.rpc.model.ServiceModel), var1146_identityHashCode/1096208673=([java.lang.Object], int), cast-from-var529-to-var3254=([org.apache.dubbo.rpc.model.ConsumerModel], java.lang.Object), Int_toHexString/1865784998=([int], java.lang.String), var399-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var2316_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3254=([java.lang.String], java.lang.Object), cast-from-var399-to-var3254=([java.util.HashMap], java.lang.Object), getServiceMetadata/703324177=([org.apache.dubbo.rpc.model.ServiceModel], org.apache.dubbo.rpc.model.ServiceMetadata), getAttribute/-355102655=([org.apache.dubbo.rpc.model.ServiceMetadata, java.lang.String], java.lang.Object)}
; {var2023=r0, var2316=java.util.Map, var2418=r9, var529=org.apache.dubbo.rpc.model.ConsumerModel, var1452=r1, var776=$r3, var1114=org.apache.dubbo.rpc.model.ServiceModel, var9=$r2, var2=$r4, var1624=$r6, var1146=java.lang.System, var3254=java.lang.Object, var1478=$i0, var2024=$r5, var679=$r7, var399=java.util.HashMap, var395=$r8, var3656=$r10, var842=$r11, var37=$r12, var3021=$r14, var1261=$i1, var310=$r13, var2639=$r15, var2525=$r16, var1253=org.apache.dubbo.rpc.model.ServiceMetadata, var1135=$r17, var1937=r18, var596=$z0}
; {r0=var2023, java.util.Map=var2316, r9=var2418, org.apache.dubbo.rpc.model.ConsumerModel=var529, r1=var1452, $r3=var776, org.apache.dubbo.rpc.model.ServiceModel=var1114, $r2=var9, $r4=var2, $r6=var1624, java.lang.System=var1146, java.lang.Object=var3254, $i0=var1478, $r5=var2024, $r7=var679, java.util.HashMap=var399, $r8=var395, $r10=var3656, $r11=var842, $r12=var37, $r14=var3021, $i1=var1261, $r13=var310, $r15=var2639, $r16=var2525, org.apache.dubbo.rpc.model.ServiceMetadata=var1253, $r17=var1135, r18=var1937, $z0=var596}
;seq <java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 8,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.StringBuilder;	r9 := @parameter1: java.util.Map;	r1 := @parameter2: org.apache.dubbo.rpc.model.ConsumerModel;	$r3 = virtualinvoke r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ConsumerModel: ");	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ConsumerModel: java.lang.String getServiceKey()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("@");	$i0 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r1);	$r5 = staticinvoke <java.lang.Integer: java.lang.String toHexString(int)>($i0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\n");	$r8 = new java.util.HashMap;	specialinvoke $r8.<java.util.HashMap: void <init>()>();	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ConsumerModel: java.lang.String getServiceKey()>();	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r11);	$r14 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("@");	$i1 = staticinvoke <java.lang.System: int identityHashCode(java.lang.Object)>(r1);	$r13 = staticinvoke <java.lang.Integer: java.lang.String toHexString(int)>($i1);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke r9.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r16, $r8);	$r17 = virtualinvoke r1.<org.apache.dubbo.rpc.model.ConsumerModel: org.apache.dubbo.rpc.model.ServiceMetadata getServiceMetadata()>();	r18 = virtualinvoke $r17.<org.apache.dubbo.rpc.model.ServiceMetadata: java.lang.Object getAttribute(java.lang.String)>("currentClusterInvoker");	$z0 = r18 instanceof java.util.Map;	if $z0 == 0 goto return;	return
;block_num 2