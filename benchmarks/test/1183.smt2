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

(declare-sort var2589 0)
(declare-sort var3211 0)
(declare-sort var3034 0)
(declare-sort var3386 0)
(declare-sort var2274 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun index/1102314961 (var2589) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun type/1102314961 (var2589) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun str_value/1102314961 (var2589) var3211)
(declare-fun append/-1031950772 (String var3034) String)
(declare-fun cast-from-var3211-to-var3034 (var3211) var3034)
(declare-fun num_value/1102314961 (var2589) var3386)
(declare-fun cast-from-var3386-to-var3034 (var3386) var3034)
(declare-fun bool_value/1102314961 (var2589) var2274)
(declare-fun cast-from-var2274-to-var3034 (var2274) var3034)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2589 var2589)
(declare-const var892 var2589) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg 
(assert (not (= var892 null-var2589)))
(define-const var940 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var940)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var940!1 String)
(assert (= var940!1 ""))
(assert true)
(define-const var3896 String (append/672562846 var940!1 "DubboMethodArg{index=")) ; Statement: $r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DubboMethodArg{index=") 
(declare-const var940!2 String)
(assert (= var940!2 (str.++ var940!1 "DubboMethodArg{index=")))
(define-const var3554 Int (index/1102314961 var892)) ; Statement: $i0 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg: int index> 
(assert true)
(define-const var2785 String (append/-1001720160 var3896 var3554)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3896!1 String)
(assert (str.prefixof var3896 var3896!1))
(assert true)
(define-const var770 String (append/672562846 var2785 ", type=\u0027")) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", type=\'") 
(declare-const var2785!1 String)
(assert (= var2785!1 (str.++ var2785 ", type=\u0027")))
(define-const var3291 String (type/1102314961 var892)) ; Statement: $r4 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg: java.lang.String type> 
(assert true)
(define-const var2497 String (append/672562846 var770 var3291)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var770!1 String)
(assert (= var770!1 (str.++ var770 var3291)))
(assert true)
(define-const var3996 String (append/-1166366385 var2497 39)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var2497!1 String)
(assert (str.prefixof var2497 var2497!1))
(assert true)
(define-const var3593 String (append/672562846 var3996 ", str_value=")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", str_value=") 
(declare-const var3996!1 String)
(assert (= var3996!1 (str.++ var3996 ", str_value=")))
(define-const var3973 var3211 (str_value/1102314961 var892)) ; Statement: $r8 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.ListStringMatch str_value> 
(assert true)
(define-const var1793 String (append/-1031950772 var3593 (cast-from-var3211-to-var3034 var3973))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var3593!1 String)
(assert (str.prefixof var3593 var3593!1))
(assert true)
(define-const var578 String (append/672562846 var1793 ", num_value=")) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", num_value=") 
(declare-const var1793!1 String)
(assert (= var1793!1 (str.++ var1793 ", num_value=")))
(define-const var2376 var3386 (num_value/1102314961 var892)) ; Statement: $r11 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.ListDoubleMatch num_value> 
(assert true)
(define-const var2541 String (append/-1031950772 var578 (cast-from-var3386-to-var3034 var2376))) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r11) 
(declare-const var578!1 String)
(assert (str.prefixof var578 var578!1))
(assert true)
(define-const var785 String (append/672562846 var2541 ", bool_value=")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", bool_value=") 
(declare-const var2541!1 String)
(assert (= var2541!1 (str.++ var2541 ", bool_value=")))
(define-const var2578 var2274 (bool_value/1102314961 var892)) ; Statement: $r14 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.BoolMatch bool_value> 
(assert true)
(define-const var93 String (append/-1031950772 var785 (cast-from-var2274-to-var3034 var2578))) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14) 
(declare-const var785!1 String)
(assert (str.prefixof var785 var785!1))
(assert true)
(define-const var956 String (append/-1166366385 var93 125)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var93!1 String)
(assert (str.prefixof var93 var93!1))
(assert true)
(define-const var3333 String (toString/-2075883882 var956)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r18 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), index/1102314961=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), type/1102314961=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), str_value/1102314961=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg], org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.ListStringMatch), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3211-to-var3034=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.ListStringMatch], java.lang.Object), num_value/1102314961=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg], org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.ListDoubleMatch), cast-from-var3386-to-var3034=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.ListDoubleMatch], java.lang.Object), bool_value/1102314961=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg], org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.BoolMatch), cast-from-var2274-to-var3034=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.BoolMatch], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2589=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg, var892=r1, var940=$r0, var3896=$r2, var3554=$i0, var2785=$r3, var770=$r5, var3291=$r4, var2497=$r6, var3996=$r7, var3593=$r9, var3211=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.ListStringMatch, var3973=$r8, var3034=java.lang.Object, var1793=$r10, var578=$r12, var3386=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.ListDoubleMatch, var2376=$r11, var2541=$r13, var785=$r15, var2274=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.BoolMatch, var2578=$r14, var93=$r16, var956=$r17, var3333=$r18}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg=var2589, r1=var892, $r0=var940, $r2=var3896, $i0=var3554, $r3=var2785, $r5=var770, $r4=var3291, $r6=var2497, $r7=var3996, $r9=var3593, org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.ListStringMatch=var3211, $r8=var3973, java.lang.Object=var3034, $r10=var1793, $r12=var578, org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.ListDoubleMatch=var3386, $r11=var2376, $r13=var2541, $r15=var785, org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.BoolMatch=var2274, $r14=var2578, $r16=var93, $r17=var956, $r18=var3333}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DubboMethodArg{index=");	$i0 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg: int index>;	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", type=\'");	$r4 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg: java.lang.String type>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", str_value=");	$r8 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.ListStringMatch str_value>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", num_value=");	$r11 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.ListDoubleMatch num_value>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r11);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", bool_value=");	$r14 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodArg: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.BoolMatch bool_value>;	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	return $r18
;block_num 1