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

(declare-sort var2238 0)
(declare-sort var1016 0)
(declare-sort var1898 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getProtocol/491749358 (var2238) String)
(declare-fun var1016_isNotEmpty/-1251449450 (String) Bool)
(declare-fun urlAddress/1606454354 (var2238) var1898)
(declare-fun getIp/116471783 (var1898) String)
(declare-fun getPath/898047937 (var2238) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2238 var2238)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1782 var2238) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1782 null-var2238)))
(declare-const var3740 Bool) ; Statement: z1 := @parameter0: boolean 
(assert (not (= var3740 null-Bool)))
(declare-const var445 Bool) ; Statement: z6 := @parameter1: boolean 
(assert (not (= var445 null-Bool)))
(declare-const var411 Bool) ; Statement: z2 := @parameter2: boolean 
(assert (not (= var411 null-Bool)))
(declare-const var867 Bool) ; Statement: z4 := @parameter3: boolean 
(assert (not (= var867 null-Bool)))
(declare-const var3819 (Array Int String)) ; Statement: r4 := @parameter4: java.lang.String[] 
(assert (not (= var3819 null-__Array__Int__String__)))
(define-const var1253 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1253)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1253!1 String)
(assert (= var1253!1 ""))
(assert true)
(define-const var2251 String (getProtocol/491749358 var1782)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(define-const var1459 Bool (var1016_isNotEmpty/-1251449450 var2251)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var1459 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if z1 == 0 goto (branch) 
(assert (= (ite var3740 1 0) 0)) ; Cond: z1 == 0 
 ; Statement: if z2 == 0 goto r11 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert (not (= (ite var411 1 0) 0))) ; Negate: Cond: z2 == 0  
(define-const var1323 var1898 (urlAddress/1606454354 var1782)) ; Statement: $r5 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> 
(assert true)
(define-const var2204 String (getIp/116471783 var1323)) ; Statement: r11 = virtualinvoke $r5.<org.apache.dubbo.common.url.component.URLAddress: java.lang.String getIp()>() 
 ; Statement: goto [?= $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r11)] 
(assert true) ; Non Conditional
(define-const var26 Bool (var1016_isNotEmpty/-1251449450 var2204)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r11) 
 ; Statement: if $z3 == 0 goto (branch) 
(assert (= (ite var26 1 0) 0)) ; Cond: $z3 == 0 
 ; Statement: if z4 == 0 goto r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert (= (ite var867 1 0) 0)) ; Cond: z4 == 0 
(assert true)
(define-const var2636 String (getPath/898047937 var1782)) ; Statement: r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert true) ; Non Conditional
(define-const var1281 Bool (var1016_isNotEmpty/-1251449450 var2636)) ; Statement: $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12) 
 ; Statement: if $z5 == 0 goto (branch) 
(assert (= (ite var1281 1 0) 0)) ; Cond: $z5 == 0 
 ; Statement: if z6 == 0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var445 1 0) 0)) ; Cond: z6 == 0 
(assert true)
(define-const var3251 String (toString/-2075883882 var1253!1)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), var1016_isNotEmpty/-1251449450=([java.lang.String], boolean), urlAddress/1606454354=([org.apache.dubbo.common.URL], org.apache.dubbo.common.url.component.URLAddress), getIp/116471783=([org.apache.dubbo.common.url.component.URLAddress], java.lang.String), getPath/898047937=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2238=org.apache.dubbo.common.URL, var1782=r1, var3740=z1, var445=z6, var411=z2, var867=z4, var3819=r4, var1253=$r0, var2251=$r2, var1016=org.apache.dubbo.common.utils.StringUtils, var1459=$z0, var1898=org.apache.dubbo.common.url.component.URLAddress, var1323=$r5, var2204=r11, var26=$z3, var2636=r12, var1281=$z5, var3251=$r3}
; {org.apache.dubbo.common.URL=var2238, r1=var1782, z1=var3740, z6=var445, z2=var411, z4=var867, r4=var3819, $r0=var1253, $r2=var2251, org.apache.dubbo.common.utils.StringUtils=var1016, $z0=var1459, org.apache.dubbo.common.url.component.URLAddress=var1898, $r5=var1323, r11=var2204, $z3=var26, r12=var2636, $z5=var1281, $r3=var3251}
;seq <java.lang.StringBuilder: void <init>()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	z1 := @parameter0: boolean;	z6 := @parameter1: boolean;	z2 := @parameter2: boolean;	z4 := @parameter3: boolean;	r4 := @parameter4: java.lang.String[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	if $z0 == 0 goto (branch);	if z1 == 0 goto (branch);	if z2 == 0 goto r11 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	$r5 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	r11 = virtualinvoke $r5.<org.apache.dubbo.common.url.component.URLAddress: java.lang.String getIp()>();	goto [?= $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r11)];	$z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r11);	if $z3 == 0 goto (branch);	if z4 == 0 goto r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	$z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12);	if $z5 == 0 goto (branch);	if z6 == 0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 10