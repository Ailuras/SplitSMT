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

(declare-sort var3400 0)
(declare-sort var1102 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getUserInformation/531207443 (var3400) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getHost/-1506772130 (var3400) String)
(declare-fun var1102_isNotEmpty/-1251449450 (String) Bool)
(declare-fun length/-171891354 (String) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3400 var3400)
(declare-const var3613 var3400) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3613 null-var3400)))
(define-const var1417 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1417)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1417!1 String)
(assert (= var1417!1 ""))
(assert true)
(define-const var2945 String (getUserInformation/531207443 var3613)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUserInformation()>() 
(assert true)
;(assert (append/672562846 var1417!1 var2945)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var1417!2 String)
(assert (= var1417!2 (str.++ var1417!1 var2945)))
(assert true)
(define-const var1060 String (getHost/-1506772130 var3613)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(define-const var2024 Bool (var1102_isNotEmpty/-1251449450 var1060)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3) 
 ; Statement: if $z0 == 0 goto $i2 = virtualinvoke $r0.<java.lang.StringBuilder: int length()>() 
(assert (= (ite var2024 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var466 Int (length/-171891354 var1417!2)) ; Statement: $i2 = virtualinvoke $r0.<java.lang.StringBuilder: int length()>() 
 ; Statement: if $i2 != 0 goto $r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (not (= var466 0))) ; Cond: $i2 != 0 
(assert true)
(define-const var950 String (toString/-2075883882 var1417!2)) ; Statement: $r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true) ; Non Conditional
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getUserInformation/531207443=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), var1102_isNotEmpty/-1251449450=([java.lang.String], boolean), length/-171891354=([java.lang.StringBuilder], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3400=org.apache.dubbo.common.URL, var3613=r1, var1417=$r0, var2945=$r2, var1060=$r3, var1102=org.apache.dubbo.common.utils.StringUtils, var2024=$z0, var466=$i2, var950=$r7}
; {org.apache.dubbo.common.URL=var3400, r1=var3613, $r0=var1417, $r2=var2945, $r3=var1060, org.apache.dubbo.common.utils.StringUtils=var1102, $z0=var2024, $i2=var466, $r7=var950}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: int length()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: int length()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUserInformation()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3);	if $z0 == 0 goto $i2 = virtualinvoke $r0.<java.lang.StringBuilder: int length()>();	$i2 = virtualinvoke $r0.<java.lang.StringBuilder: int length()>();	if $i2 != 0 goto $r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 4