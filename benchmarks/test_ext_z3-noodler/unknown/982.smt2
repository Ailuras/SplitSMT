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

(declare-sort var2068 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun exact/-253071878 (var2068) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun prefix/-253071878 (var2068) String)
(declare-fun regex/-253071878 (var2068) String)
(declare-fun noempty/-253071878 (var2068) String)
(declare-fun empty/-253071878 (var2068) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2068 var2068)
(declare-const var2563 var2068) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch 
(assert (not (= var2563 null-var2068)))
(define-const var3969 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3969)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3969!1 String)
(assert (= var3969!1 ""))
(assert true)
(define-const var2165 String (append/672562846 var3969!1 "StringMatch{exact=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("StringMatch{exact=\'") 
(declare-const var3969!2 String)
(assert (= var3969!2 (str.++ var3969!1 "StringMatch{exact=\u0027")))
(define-const var194 String (exact/-253071878 var2563)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String exact> 
(assert true)
(define-const var1153 String (append/672562846 var2165 var194)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2165!1 String)
(assert (= var2165!1 (str.++ var2165 var194)))
(assert true)
(define-const var2888 String (append/-1166366385 var1153 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var1153!1 String)
(assert (str.prefixof var1153 var1153!1))
(assert true)
(define-const var1556 String (append/672562846 var2888 ", prefix=\u0027")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", prefix=\'") 
(declare-const var2888!1 String)
(assert (= var2888!1 (str.++ var2888 ", prefix=\u0027")))
(define-const var263 String (prefix/-253071878 var2563)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String prefix> 
(assert true)
(define-const var2162 String (append/672562846 var1556 var263)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var1556!1 String)
(assert (= var1556!1 (str.++ var1556 var263)))
(assert true)
(define-const var3663 String (append/-1166366385 var2162 39)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var2162!1 String)
(assert (str.prefixof var2162 var2162!1))
(assert true)
(define-const var3713 String (append/672562846 var3663 ", regex=\u0027")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", regex=\'") 
(declare-const var3663!1 String)
(assert (= var3663!1 (str.++ var3663 ", regex=\u0027")))
(define-const var260 String (regex/-253071878 var2563)) ; Statement: $r10 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String regex> 
(assert true)
(define-const var2587 String (append/672562846 var3713 var260)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var3713!1 String)
(assert (= var3713!1 (str.++ var3713 var260)))
(assert true)
(define-const var1262 String (append/-1166366385 var2587 39)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var2587!1 String)
(assert (str.prefixof var2587 var2587!1))
(assert true)
(define-const var2598 String (append/672562846 var1262 ", noempty=\u0027")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", noempty=\'") 
(declare-const var1262!1 String)
(assert (= var1262!1 (str.++ var1262 ", noempty=\u0027")))
(define-const var1053 String (noempty/-253071878 var2563)) ; Statement: $r14 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String noempty> 
(assert true)
(define-const var402 String (append/672562846 var2598 var1053)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var2598!1 String)
(assert (= var2598!1 (str.++ var2598 var1053)))
(assert true)
(define-const var2606 String (append/-1166366385 var402 39)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var402!1 String)
(assert (str.prefixof var402 var402!1))
(assert true)
(define-const var3069 String (append/672562846 var2606 ", empty=\u0027")) ; Statement: $r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", empty=\'") 
(declare-const var2606!1 String)
(assert (= var2606!1 (str.++ var2606 ", empty=\u0027")))
(define-const var1645 String (empty/-253071878 var2563)) ; Statement: $r18 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String empty> 
(assert true)
(define-const var3033 String (append/672562846 var3069 var1645)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18) 
(declare-const var3069!1 String)
(assert (= var3069!1 (str.++ var3069 var1645)))
(assert true)
(define-const var642 String (append/-1166366385 var3033 39)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var3033!1 String)
(assert (str.prefixof var3033 var3033!1))
(assert true)
(define-const var3641 String (append/-1166366385 var642 125)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var642!1 String)
(assert (str.prefixof var642 var642!1))
(assert true)
(define-const var536 String (toString/-2075883882 var3641)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r23 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), exact/-253071878=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), prefix/-253071878=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch], java.lang.String), regex/-253071878=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch], java.lang.String), noempty/-253071878=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch], java.lang.String), empty/-253071878=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2068=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch, var2563=r1, var3969=$r0, var2165=$r3, var194=$r2, var1153=$r4, var2888=$r5, var1556=$r7, var263=$r6, var2162=$r8, var3663=$r9, var3713=$r11, var260=$r10, var2587=$r12, var1262=$r13, var2598=$r15, var1053=$r14, var402=$r16, var2606=$r17, var3069=$r19, var1645=$r18, var3033=$r20, var642=$r21, var3641=$r22, var536=$r23}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch=var2068, r1=var2563, $r0=var3969, $r3=var2165, $r2=var194, $r4=var1153, $r5=var2888, $r7=var1556, $r6=var263, $r8=var2162, $r9=var3663, $r11=var3713, $r10=var260, $r12=var2587, $r13=var1262, $r15=var2598, $r14=var1053, $r16=var402, $r17=var2606, $r19=var3069, $r18=var1645, $r20=var3033, $r21=var642, $r22=var3641, $r23=var536}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("StringMatch{exact=\'");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String exact>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", prefix=\'");	$r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String prefix>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", regex=\'");	$r10 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String regex>;	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", noempty=\'");	$r14 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String noempty>;	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", empty=\'");	$r18 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch: java.lang.String empty>;	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18);	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	return $r23
;block_num 1