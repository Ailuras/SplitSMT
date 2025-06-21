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

(declare-sort var600 0)
(declare-sort var1200 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun app/-2112725066 (var600) String)
(declare-fun revision/-2112725066 (var600) String)
(declare-fun services/-2112725066 (var600) var1200)
(declare-fun var1200_size/-1594421051 (var1200) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun getSimplifiedServices/-68855662 (var600 var1200) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var600 var600)
(declare-const null-var1200 var1200)
(declare-const var991 var600) ; Statement: r1 := @this: org.apache.dubbo.metadata.MetadataInfo 
(assert (not (= var991 null-var600)))
(define-const var1232 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1232)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1232!1 String)
(assert (= var1232!1 ""))
(assert true)
(define-const var1260 String (append/672562846 var1232!1 "metadata{app=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("metadata{app=\'") 
(declare-const var1232!2 String)
(assert (= var1232!2 (str.++ var1232!1 "metadata{app=\u0027")))
(define-const var995 String (app/-2112725066 var991)) ; Statement: $r2 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String app> 
(assert true)
(define-const var3102 String (append/672562846 var1260 var995)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1260!1 String)
(assert (= var1260!1 (str.++ var1260 var995)))
(assert true)
(define-const var575 String (append/672562846 var3102 "\u0027,revision=\u0027")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',revision=\'") 
(declare-const var3102!1 String)
(assert (= var3102!1 (str.++ var3102 "\u0027,revision=\u0027")))
(define-const var1132 String (revision/-2112725066 var991)) ; Statement: $r5 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String revision> 
(assert true)
(define-const var3426 String (append/672562846 var575 var1132)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var575!1 String)
(assert (= var575!1 (str.++ var575 var1132)))
(assert true)
(define-const var1784 String (append/672562846 var3426 "\u0027,size=")) ; Statement: $r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',size=") 
(declare-const var3426!1 String)
(assert (= var3426!1 (str.++ var3426 "\u0027,size=")))
(define-const var1034 var1200 (services/-2112725066 var991)) ; Statement: $r8 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services> 
 ; Statement: if $r8 != null goto $r9 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services> 
(assert (not (= var1034 null-var1200))) ; Cond: $r8 != null 
(define-const var3651 var1200 (services/-2112725066 var991)) ; Statement: $r9 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services> 
(define-const var1723 Int (var1200_size/-1594421051 var3651)) ; Statement: $i0 = interfaceinvoke $r9.<java.util.Map: int size()>() 
(assert true) ; Non Conditional
(assert true)
(define-const var508 String (append/-1001720160 var1784 var1723)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1784!1 String)
(assert (str.prefixof var1784 var1784!1))
(assert true)
(define-const var52 String (append/672562846 var508 ",services=")) ; Statement: $r14 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",services=") 
(declare-const var508!1 String)
(assert (= var508!1 (str.++ var508 ",services=")))
(define-const var2585 var1200 (services/-2112725066 var991)) ; Statement: $r12 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services> 
(assert true)
(define-const var3239 String (getSimplifiedServices/-68855662 var991 var2585)) ; Statement: $r13 = specialinvoke r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String getSimplifiedServices(java.util.Map)>($r12) 
(assert true)
(define-const var2489 String (append/672562846 var52 var3239)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var52!1 String)
(assert (= var52!1 (str.++ var52 var3239)))
(assert true)
(define-const var1280 String (append/672562846 var2489 "}")) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}") 
(declare-const var2489!1 String)
(assert (= var2489!1 (str.++ var2489 "}")))
(assert true)
(define-const var3725 String (toString/-2075883882 var1280)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r17 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), app/-2112725066=([org.apache.dubbo.metadata.MetadataInfo], java.lang.String), revision/-2112725066=([org.apache.dubbo.metadata.MetadataInfo], java.lang.String), services/-2112725066=([org.apache.dubbo.metadata.MetadataInfo], java.util.Map), var1200_size/-1594421051=([java.util.Map], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), getSimplifiedServices/-68855662=([org.apache.dubbo.metadata.MetadataInfo, java.util.Map], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var600=org.apache.dubbo.metadata.MetadataInfo, var991=r1, var1232=$r0, var1260=$r3, var995=$r2, var3102=$r4, var575=$r6, var1132=$r5, var3426=$r7, var1784=$r10, var1200=java.util.Map, var1034=$r8, var3651=$r9, var1723=$i0, var508=$r11, var52=$r14, var2585=$r12, var3239=$r13, var2489=$r15, var1280=$r16, var3725=$r17}
; {org.apache.dubbo.metadata.MetadataInfo=var600, r1=var991, $r0=var1232, $r3=var1260, $r2=var995, $r4=var3102, $r6=var575, $r5=var1132, $r7=var3426, $r10=var1784, java.util.Map=var1200, $r8=var1034, $r9=var3651, $i0=var1723, $r11=var508, $r14=var52, $r12=var2585, $r13=var3239, $r15=var2489, $r16=var1280, $r17=var3725}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 8,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.MetadataInfo;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("metadata{app=\'");	$r2 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String app>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',revision=\'");	$r5 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String revision>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',size=");	$r8 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services>;	if $r8 != null goto $r9 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services>;	$r9 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services>;	$i0 = interfaceinvoke $r9.<java.util.Map: int size()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r14 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",services=");	$r12 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services>;	$r13 = specialinvoke r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String getSimplifiedServices(java.util.Map)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	return $r17
;block_num 3