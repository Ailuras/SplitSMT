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

(declare-sort var2439 0)
(declare-sort var748 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun application/-1480573028 (var2439) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun serviceInterface/1102404120 (var748) String)
(declare-fun cast-from-var2439-to-var748 (var2439) var748)
(declare-fun version/1102404120 (var748) String)
(declare-fun group/1102404120 (var748) String)
(declare-fun side/1102404120 (var748) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2439 var2439)
(declare-const var3437 var2439) ; Statement: r1 := @this: org.apache.dubbo.metadata.report.identifier.MetadataIdentifier 
(assert (not (= var3437 null-var2439)))
(define-const var3263 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3263)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3263!1 String)
(assert (= var3263!1 ""))
(assert true)
(define-const var1502 String (append/672562846 var3263!1 "MetadataIdentifier{application=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MetadataIdentifier{application=\'") 
(declare-const var3263!2 String)
(assert (= var3263!2 (str.++ var3263!1 "MetadataIdentifier{application=\u0027")))
(define-const var519 String (application/-1480573028 var3437)) ; Statement: $r2 = r1.<org.apache.dubbo.metadata.report.identifier.MetadataIdentifier: java.lang.String application> 
(assert true)
(define-const var3660 String (append/672562846 var1502 var519)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1502!1 String)
(assert (= var1502!1 (str.++ var1502 var519)))
(assert true)
(define-const var1351 String (append/-1166366385 var3660 39)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var3660!1 String)
(assert (str.prefixof var3660 var3660!1))
(assert true)
(define-const var2799 String (append/672562846 var1351 ", serviceInterface=\u0027")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", serviceInterface=\'") 
(declare-const var1351!1 String)
(assert (= var1351!1 (str.++ var1351 ", serviceInterface=\u0027")))
(define-const var934 String (serviceInterface/1102404120 (cast-from-var2439-to-var748 var3437))) ; Statement: $r6 = r1.<org.apache.dubbo.metadata.report.identifier.MetadataIdentifier: java.lang.String serviceInterface> 
(assert true)
(define-const var2675 String (append/672562846 var2799 var934)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2799!1 String)
(assert (= var2799!1 (str.++ var2799 var934)))
(assert true)
(define-const var1697 String (append/-1166366385 var2675 39)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var2675!1 String)
(assert (str.prefixof var2675 var2675!1))
(assert true)
(define-const var811 String (append/672562846 var1697 ", version=\u0027")) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", version=\'") 
(declare-const var1697!1 String)
(assert (= var1697!1 (str.++ var1697 ", version=\u0027")))
(define-const var230 String (version/1102404120 (cast-from-var2439-to-var748 var3437))) ; Statement: $r10 = r1.<org.apache.dubbo.metadata.report.identifier.MetadataIdentifier: java.lang.String version> 
(assert true)
(define-const var2766 String (append/672562846 var811 var230)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10) 
(declare-const var811!1 String)
(assert (= var811!1 (str.++ var811 var230)))
(assert true)
(define-const var2147 String (append/-1166366385 var2766 39)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var2766!1 String)
(assert (str.prefixof var2766 var2766!1))
(assert true)
(define-const var3545 String (append/672562846 var2147 ", group=\u0027")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", group=\'") 
(declare-const var2147!1 String)
(assert (= var2147!1 (str.++ var2147 ", group=\u0027")))
(define-const var2740 String (group/1102404120 (cast-from-var2439-to-var748 var3437))) ; Statement: $r14 = r1.<org.apache.dubbo.metadata.report.identifier.MetadataIdentifier: java.lang.String group> 
(assert true)
(define-const var2041 String (append/672562846 var3545 var2740)) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14) 
(declare-const var3545!1 String)
(assert (= var3545!1 (str.++ var3545 var2740)))
(assert true)
(define-const var129 String (append/-1166366385 var2041 39)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var2041!1 String)
(assert (str.prefixof var2041 var2041!1))
(assert true)
(define-const var1594 String (append/672562846 var129 ", side=\u0027")) ; Statement: $r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", side=\'") 
(declare-const var129!1 String)
(assert (= var129!1 (str.++ var129 ", side=\u0027")))
(define-const var2133 String (side/1102404120 (cast-from-var2439-to-var748 var3437))) ; Statement: $r18 = r1.<org.apache.dubbo.metadata.report.identifier.MetadataIdentifier: java.lang.String side> 
(assert true)
(define-const var432 String (append/672562846 var1594 var2133)) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18) 
(declare-const var1594!1 String)
(assert (= var1594!1 (str.++ var1594 var2133)))
(assert true)
(define-const var327 String (append/-1166366385 var432 39)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39) 
(declare-const var432!1 String)
(assert (str.prefixof var432 var432!1))
(assert true)
(define-const var202 String (append/-1166366385 var327 125)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var327!1 String)
(assert (str.prefixof var327 var327!1))
(assert true)
(define-const var2769 String (toString/-2075883882 var202)) ; Statement: $r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r23 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), application/-1480573028=([org.apache.dubbo.metadata.report.identifier.MetadataIdentifier], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), serviceInterface/1102404120=([org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier], java.lang.String), cast-from-var2439-to-var748=([org.apache.dubbo.metadata.report.identifier.MetadataIdentifier], org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier), version/1102404120=([org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier], java.lang.String), group/1102404120=([org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier], java.lang.String), side/1102404120=([org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2439=org.apache.dubbo.metadata.report.identifier.MetadataIdentifier, var3437=r1, var3263=$r0, var1502=$r3, var519=$r2, var3660=$r4, var1351=$r5, var2799=$r7, var748=org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier, var934=$r6, var2675=$r8, var1697=$r9, var811=$r11, var230=$r10, var2766=$r12, var2147=$r13, var3545=$r15, var2740=$r14, var2041=$r16, var129=$r17, var1594=$r19, var2133=$r18, var432=$r20, var327=$r21, var202=$r22, var2769=$r23}
; {org.apache.dubbo.metadata.report.identifier.MetadataIdentifier=var2439, r1=var3437, $r0=var3263, $r3=var1502, $r2=var519, $r4=var3660, $r5=var1351, $r7=var2799, org.apache.dubbo.metadata.report.identifier.BaseServiceMetadataIdentifier=var748, $r6=var934, $r8=var2675, $r9=var1697, $r11=var811, $r10=var230, $r12=var2766, $r13=var2147, $r15=var3545, $r14=var2740, $r16=var2041, $r17=var129, $r19=var1594, $r18=var2133, $r20=var432, $r21=var327, $r22=var202, $r23=var2769}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 6,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.report.identifier.MetadataIdentifier;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("MetadataIdentifier{application=\'");	$r2 = r1.<org.apache.dubbo.metadata.report.identifier.MetadataIdentifier: java.lang.String application>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", serviceInterface=\'");	$r6 = r1.<org.apache.dubbo.metadata.report.identifier.MetadataIdentifier: java.lang.String serviceInterface>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", version=\'");	$r10 = r1.<org.apache.dubbo.metadata.report.identifier.MetadataIdentifier: java.lang.String version>;	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r10);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", group=\'");	$r14 = r1.<org.apache.dubbo.metadata.report.identifier.MetadataIdentifier: java.lang.String group>;	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r14);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r19 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", side=\'");	$r18 = r1.<org.apache.dubbo.metadata.report.identifier.MetadataIdentifier: java.lang.String side>;	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r18);	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(39);	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r23 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.String toString()>();	return $r23
;block_num 1