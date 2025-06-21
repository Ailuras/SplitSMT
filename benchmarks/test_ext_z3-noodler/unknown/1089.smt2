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

(declare-sort var1311 0)
(declare-sort var1423 0)
(declare-sort var1206 0)
(declare-sort var2651 0)
(declare-sort var2486 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name/670188183 (var1311) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun method/670188183 (var1311) var1423)
(declare-fun append/-1031950772 (String var1206) String)
(declare-fun cast-from-var1423-to-var1206 (var1423) var1206)
(declare-fun sourceLabels/670188183 (var1311) var2651)
(declare-fun cast-from-var2651-to-var1206 (var2651) var1206)
(declare-fun attachments/670188183 (var1311) var2486)
(declare-fun cast-from-var2486-to-var1206 (var2486) var1206)
(declare-fun headers/670188183 (var1311) var2651)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1311 var1311)
(declare-const var24 var1311) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest 
(assert (not (= var24 null-var1311)))
(define-const var858 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var858)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var858!1 String)
(assert (= var858!1 ""))
(assert true)
(define-const var2781 String (append/672562846 var858!1 "DubboMatchRequest{name=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DubboMatchRequest{name=\'") 
(declare-const var858!2 String)
(assert (= var858!2 (str.++ var858!1 "DubboMatchRequest{name=\u0027")))
(define-const var1237 String (name/670188183 var24)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest: java.lang.String name> 
(assert true)
(define-const var3410 String (append/672562846 var2781 var1237)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2781!1 String)
(assert (= var2781!1 (str.++ var2781 var1237)))
(assert true)
(define-const var1694 String (append/-1166366385 var3410 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var3410!1 String)
(assert (str.prefixof var3410 var3410!1))
(assert true)
(define-const var3004 String (append/672562846 var1694 ", method=")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method=") 
(declare-const var1694!1 String)
(assert (= var1694!1 (str.++ var1694 ", method=")))
(define-const var1179 var1423 (method/670188183 var24)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch method> 
(assert true)
(define-const var1780 String (append/-1031950772 var3004 (cast-from-var1423-to-var1206 var1179))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var3004!1 String)
(assert (str.prefixof var3004 var3004!1))
(assert true)
(define-const var3287 String (append/672562846 var1780 ", sourceLabels=")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", sourceLabels=") 
(declare-const var1780!1 String)
(assert (= var1780!1 (str.++ var1780 ", sourceLabels=")))
(define-const var3606 var2651 (sourceLabels/670188183 var24)) ; Statement: $r9 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest: java.util.Map sourceLabels> 
(assert true)
(define-const var1942 String (append/-1031950772 var3287 (cast-from-var2651-to-var1206 var3606))) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9) 
(declare-const var3287!1 String)
(assert (str.prefixof var3287 var3287!1))
(assert true)
(define-const var645 String (append/672562846 var1942 ", attachments=")) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", attachments=") 
(declare-const var1942!1 String)
(assert (= var1942!1 (str.++ var1942 ", attachments=")))
(define-const var3260 var2486 (attachments/670188183 var24)) ; Statement: $r12 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboAttachmentMatch attachments> 
(assert true)
(define-const var1211 String (append/-1031950772 var645 (cast-from-var2486-to-var1206 var3260))) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r12) 
(declare-const var645!1 String)
(assert (str.prefixof var645 var645!1))
(assert true)
(define-const var3550 String (append/672562846 var1211 ", headers=")) ; Statement: $r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", headers=") 
(declare-const var1211!1 String)
(assert (= var1211!1 (str.++ var1211 ", headers=")))
(define-const var1588 var2651 (headers/670188183 var24)) ; Statement: $r15 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest: java.util.Map headers> 
(assert true)
(define-const var2459 String (append/-1031950772 var3550 (cast-from-var2651-to-var1206 var1588))) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r15) 
(declare-const var3550!1 String)
(assert (str.prefixof var3550 var3550!1))
(assert true)
(define-const var2491 String (append/-1166366385 var2459 125)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var2459!1 String)
(assert (str.prefixof var2459 var2459!1))
(assert true)
(define-const var681 String (toString/-2075883882 var2491)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r19 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name/670188183=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), method/670188183=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest], org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1423-to-var1206=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch], java.lang.Object), sourceLabels/670188183=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest], java.util.Map), cast-from-var2651-to-var1206=([java.util.Map], java.lang.Object), attachments/670188183=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest], org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboAttachmentMatch), cast-from-var2486-to-var1206=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboAttachmentMatch], java.lang.Object), headers/670188183=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest], java.util.Map), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1311=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest, var24=r1, var858=$r0, var2781=$r3, var1237=$r2, var3410=$r4, var1694=$r5, var3004=$r7, var1423=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch, var1179=$r6, var1206=java.lang.Object, var1780=$r8, var3287=$r10, var2651=java.util.Map, var3606=$r9, var1942=$r11, var645=$r13, var2486=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboAttachmentMatch, var3260=$r12, var1211=$r14, var3550=$r16, var1588=$r15, var2459=$r17, var2491=$r18, var681=$r19}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest=var1311, r1=var24, $r0=var858, $r3=var2781, $r2=var1237, $r4=var3410, $r5=var1694, $r7=var3004, org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch=var1423, $r6=var1179, java.lang.Object=var1206, $r8=var1780, $r10=var3287, java.util.Map=var2651, $r9=var3606, $r11=var1942, $r13=var645, org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboAttachmentMatch=var2486, $r12=var3260, $r14=var1211, $r16=var3550, $r15=var1588, $r17=var2459, $r18=var2491, $r19=var681}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DubboMatchRequest{name=\'");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest: java.lang.String name>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", method=");	$r6 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch method>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", sourceLabels=");	$r9 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest: java.util.Map sourceLabels>;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r9);	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", attachments=");	$r12 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboAttachmentMatch attachments>;	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r12);	$r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", headers=");	$r15 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.DubboMatchRequest: java.util.Map headers>;	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	return $r19
;block_num 1