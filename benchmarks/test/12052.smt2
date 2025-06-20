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

(declare-sort var1820 0)
(declare-sort var882 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun app/-2112725066 (var1820) String)
(declare-fun revision/-2112725066 (var1820) String)
(declare-fun services/-2112725066 (var1820) var882)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(declare-fun getSimplifiedServices/-68855662 (var1820 var882) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1820 var1820)
(declare-const null-var882 var882)
(declare-const var497 var1820) ; Statement: r1 := @this: org.apache.dubbo.metadata.MetadataInfo 
(assert (not (= var497 null-var1820)))
(define-const var2549 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2549)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2549!1 String)
(assert (= var2549!1 ""))
(assert true)
(define-const var3101 String (append/672562846 var2549!1 "metadata{app=\u0027")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("metadata{app=\'") 
(declare-const var2549!2 String)
(assert (= var2549!2 (str.++ var2549!1 "metadata{app=\u0027")))
(define-const var1822 String (app/-2112725066 var497)) ; Statement: $r2 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String app> 
(assert true)
(define-const var1013 String (append/672562846 var3101 var1822)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3101!1 String)
(assert (= var3101!1 (str.++ var3101 var1822)))
(assert true)
(define-const var2693 String (append/672562846 var1013 "\u0027,revision=\u0027")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',revision=\'") 
(declare-const var1013!1 String)
(assert (= var1013!1 (str.++ var1013 "\u0027,revision=\u0027")))
(define-const var1711 String (revision/-2112725066 var497)) ; Statement: $r5 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String revision> 
(assert true)
(define-const var417 String (append/672562846 var2693 var1711)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5) 
(declare-const var2693!1 String)
(assert (= var2693!1 (str.++ var2693 var1711)))
(assert true)
(define-const var3748 String (append/672562846 var417 "\u0027,size=")) ; Statement: $r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',size=") 
(declare-const var417!1 String)
(assert (= var417!1 (str.++ var417 "\u0027,size=")))
(define-const var2618 var882 (services/-2112725066 var497)) ; Statement: $r8 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services> 
 ; Statement: if $r8 != null goto $r9 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services> 
(assert (not (not (= var2618 null-var882)))) ; Negate: Cond: $r8 != null  
(define-const var1186 Int 0) ; Statement: $i0 = 0 
 ; Statement: goto [?= $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0)] 
(assert true) ; Non Conditional
(assert true)
(define-const var158 String (append/-1001720160 var3748 var1186)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var3748!1 String)
(assert (str.prefixof var3748 var3748!1))
(assert true)
(define-const var2022 String (append/672562846 var158 ",services=")) ; Statement: $r14 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",services=") 
(declare-const var158!1 String)
(assert (= var158!1 (str.++ var158 ",services=")))
(define-const var3467 var882 (services/-2112725066 var497)) ; Statement: $r12 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services> 
(assert true)
(define-const var2301 String (getSimplifiedServices/-68855662 var497 var3467)) ; Statement: $r13 = specialinvoke r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String getSimplifiedServices(java.util.Map)>($r12) 
(assert true)
(define-const var2521 String (append/672562846 var2022 var2301)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13) 
(declare-const var2022!1 String)
(assert (= var2022!1 (str.++ var2022 var2301)))
(assert true)
(define-const var3653 String (append/672562846 var2521 "}")) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}") 
(declare-const var2521!1 String)
(assert (= var2521!1 (str.++ var2521 "}")))
(assert true)
(define-const var940 String (toString/-2075883882 var3653)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r17 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), app/-2112725066=([org.apache.dubbo.metadata.MetadataInfo], java.lang.String), revision/-2112725066=([org.apache.dubbo.metadata.MetadataInfo], java.lang.String), services/-2112725066=([org.apache.dubbo.metadata.MetadataInfo], java.util.Map), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), getSimplifiedServices/-68855662=([org.apache.dubbo.metadata.MetadataInfo, java.util.Map], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1820=org.apache.dubbo.metadata.MetadataInfo, var497=r1, var2549=$r0, var3101=$r3, var1822=$r2, var1013=$r4, var2693=$r6, var1711=$r5, var417=$r7, var3748=$r10, var882=java.util.Map, var2618=$r8, var1186=$i0, var158=$r11, var2022=$r14, var3467=$r12, var2301=$r13, var2521=$r15, var3653=$r16, var940=$r17}
; {org.apache.dubbo.metadata.MetadataInfo=var1820, r1=var497, $r0=var2549, $r3=var3101, $r2=var1822, $r4=var1013, $r6=var2693, $r5=var1711, $r7=var417, $r10=var3748, java.util.Map=var882, $r8=var2618, $i0=var1186, $r11=var158, $r14=var2022, $r12=var3467, $r13=var2301, $r15=var2521, $r16=var3653, $r17=var940}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 8,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.metadata.MetadataInfo;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("metadata{app=\'");	$r2 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String app>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',revision=\'");	$r5 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String revision>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r5);	$r10 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\',size=");	$r8 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services>;	if $r8 != null goto $r9 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services>;	$i0 = 0;	goto [?= $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0)];	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r14 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(",services=");	$r12 = r1.<org.apache.dubbo.metadata.MetadataInfo: java.util.Map services>;	$r13 = specialinvoke r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String getSimplifiedServices(java.util.Map)>($r12);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r13);	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.String toString()>();	return $r17
;block_num 3