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

(declare-sort var2797 0)
(declare-sort var1218 0)
(declare-sort var3902 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun app/-2112725066 (var2797) String)
(declare-fun revision/-2112725066 (var2797) String)
(declare-fun services/-2112725066 (var2797) var1218)
(declare-fun append/-1031950772 (String var3902) String)
(declare-fun cast-from-var1218-to-var3902 (var1218) var3902)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2797 var2797)
(declare-const var3016 var2797) ; Statement: r1 := @this: org.apache.dubbo.metadata.MetadataInfo 
(assert (not (= var3016 null-var2797)))
(define-const var441 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var441)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var441!1 String)
(assert (= var441!1 ""))
(assert true)
(define-const var2104 String (append/672562846 var441!1 "metadata{app=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("metadata{app=\'") 
(declare-const var441!2 String)
(assert (= var441!2 (str.++ var441!1 "metadata{app=\u0027")))
(define-const var3819 String (app/-2112725066 var3016)) ; Statement: $r2 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String app> 
(assert true)
(define-const var1860 String (append/672562846 var2104 var3819)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2104!1 String)
(assert (= var2104!1 (str.++ var2104 var3819)))
(assert true)
(define-const var633 String (append/672562846 var1860 "\u0027,revision=\u0027")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',revision=\'") 
(declare-const var1860!1 String)
(assert (= var1860!1 (str.++ var1860 "\u0027,revision=\u0027")))
(define-const var2841 String (revision/-2112725066 var3016)) ; Statement: $r5 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String revision> 
(assert true)
(define-const var3666 String (append/672562846 var633 var2841)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var633!1 String)
(assert (= var633!1 (str.++ var633 var2841)))
(assert true)
(define-const var3858 String (append/672562846 var3666 "\u0027,services=")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',services=") 
(declare-const var3666!1 String)
(assert (= var3666!1 (str.++ var3666 "\u0027,services=")))
(define-const var3326 var1218 (services/-2112725066 var3016)) ; Statement: $r8 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services> 
(assert true)
(define-const var3687 String (append/-1031950772 var3858 (cast-from-var1218-to-var3902 var3326))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var3858!1 String)
(assert (str.prefixof var3858 var3858!1))
(assert true)
(define-const var1154 String (append/672562846 var3687 "}")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}") 
(declare-const var3687!1 String)
(assert (= var3687!1 (str.++ var3687 "}")))
(assert true)
(define-const var686 String (toString/-2075883882 var1154)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), app/-2112725066=([org.apache.dubbo.metadata.MetadataInfo], java.lang.String), revision/-2112725066=([org.apache.dubbo.metadata.MetadataInfo], java.lang.String), services/-2112725066=([org.apache.dubbo.metadata.MetadataInfo], java.util.Map), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1218-to-var3902=([java.util.Map], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2797=org.apache.dubbo.metadata.MetadataInfo, var3016=r1, var441=$r0, var2104=$r3, var3819=$r2, var1860=$r4, var633=$r6, var2841=$r5, var3666=$r7, var3858=$r9, var1218=java.util.Map, var3326=$r8, var3902=java.lang.Object, var3687=$r10, var1154=$r11, var686=$r12}
; {org.apache.dubbo.metadata.MetadataInfo=var2797, r1=var3016, $r0=var441, $r3=var2104, $r2=var3819, $r4=var1860, $r6=var633, $r5=var2841, $r7=var3666, $r9=var3858, java.util.Map=var1218, $r8=var3326, java.lang.Object=var3902, $r10=var3687, $r11=var1154, $r12=var686}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.MetadataInfo;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("metadata{app=\'");	$r2 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String app>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',revision=\'");	$r5 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String revision>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',services=");	$r8 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 1