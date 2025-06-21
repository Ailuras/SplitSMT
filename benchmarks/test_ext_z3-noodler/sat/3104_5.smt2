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

(declare-sort var1170 0)
(declare-sort var8 0)
(declare-sort var874 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getUserInformation/531207443 (var1170) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getHost/-1506772130 (var1170) String)
(declare-fun var8_isNotEmpty/-1251449450 (String) Bool)
(declare-fun length/-171891354 (String) Int)
(declare-const null-var1170 var1170)
(declare-const null-String String)
(declare-const var1581 var1170) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1581 null-var1170)))
(define-const var3671 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3671)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3671!1 String)
(assert (= var3671!1 ""))
(assert true)
(define-const var1200 String (getUserInformation/531207443 var1581)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUserInformation()>() 
(assert true)
;(assert (append/672562846 var3671!1 var1200)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3671!2 String)
(assert (= var3671!2 (str.++ var3671!1 var1200)))
(assert true)
(define-const var1881 String (getHost/-1506772130 var1581)) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(define-const var3796 Bool (var8_isNotEmpty/-1251449450 var1881)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3) 
 ; Statement: if $z0 == 0 goto $i2 = virtualinvoke $r0.<java.lang.StringBuilder: int length()>() 
(assert (= (ite var3796 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2896 Int (length/-171891354 var3671!2)) ; Statement: $i2 = virtualinvoke $r0.<java.lang.StringBuilder: int length()>() 
 ; Statement: if $i2 != 0 goto $r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (not (not (= var2896 0)))) ; Negate: Cond: $i2 != 0  
(define-const var133 String null-String) ; Statement: $r7 = null 
 ; Statement: goto [?= return $r7] 
(assert true) ; Non Conditional
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getUserInformation/531207443=([org.apache.dubbo.common.URL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getHost/-1506772130=([org.apache.dubbo.common.URL], java.lang.String), var8_isNotEmpty/-1251449450=([java.lang.String], boolean), length/-171891354=([java.lang.StringBuilder], int)}
; {var1170=org.apache.dubbo.common.URL, var1581=r1, var3671=$r0, var1200=$r2, var1881=$r3, var8=org.apache.dubbo.common.utils.StringUtils, var3796=$z0, var2896=$i2, var874=null_type, var133=$r7}
; {org.apache.dubbo.common.URL=var1170, r1=var1581, $r0=var3671, $r2=var1200, $r3=var1881, org.apache.dubbo.common.utils.StringUtils=var8, $z0=var3796, $i2=var2896, null_type=var874, $r7=var133}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: int length()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: int length()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getUserInformation()>();	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r3 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r3);	if $z0 == 0 goto $i2 = virtualinvoke $r0.<java.lang.StringBuilder: int length()>();	$i2 = virtualinvoke $r0.<java.lang.StringBuilder: int length()>();	if $i2 != 0 goto $r7 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r7 = null;	goto [?= return $r7];	return $r7
;block_num 4