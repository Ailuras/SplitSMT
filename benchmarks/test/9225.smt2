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

(declare-sort var2578 0)
(declare-sort var2427 0)
(declare-sort var3146 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getProtocol/491749358 (var2578) String)
(declare-fun var2427_isNotEmpty/-1251449450 (String) Bool)
(declare-fun urlAddress/1606454354 (var2578) var3146)
(declare-fun getIp/116471783 (var3146) String)
(declare-fun getServiceKey/1456125852 (var2578) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2578 var2578)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3595 var2578) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3595 null-var2578)))
(declare-const var2373 Bool) ; Statement: z1 := @parameter0: boolean 
(assert (not (= var2373 null-Bool)))
(declare-const var3404 Bool) ; Statement: z6 := @parameter1: boolean 
(assert (not (= var3404 null-Bool)))
(declare-const var75 Bool) ; Statement: z2 := @parameter2: boolean 
(assert (not (= var75 null-Bool)))
(declare-const var1287 Bool) ; Statement: z4 := @parameter3: boolean 
(assert (not (= var1287 null-Bool)))
(declare-const var1242 (Array Int String)) ; Statement: r4 := @parameter4: java.lang.String[] 
(assert (not (= var1242 null-__Array__Int__String__)))
(define-const var2059 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2059)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2059!1 String)
(assert (= var2059!1 ""))
(assert true)
(define-const var1722 String (getProtocol/491749358 var3595)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>() 
(define-const var3175 Bool (var2427_isNotEmpty/-1251449450 var1722)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2) 
 ; Statement: if $z0 == 0 goto (branch) 
(assert (= (ite var3175 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: if z1 == 0 goto (branch) 
(assert (= (ite var2373 1 0) 0)) ; Cond: z1 == 0 
 ; Statement: if z2 == 0 goto r11 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>() 
(assert (not (= (ite var75 1 0) 0))) ; Negate: Cond: z2 == 0  
(define-const var1564 var3146 (urlAddress/1606454354 var3595)) ; Statement: $r5 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress> 
(assert true)
(define-const var1486 String (getIp/116471783 var1564)) ; Statement: r11 = virtualinvoke $r5.<org.apache.dubbo.common.url.component.URLAddress: java.lang.String getIp()>() 
 ; Statement: goto [?= $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r11)] 
(assert true) ; Non Conditional
(define-const var142 Bool (var2427_isNotEmpty/-1251449450 var1486)) ; Statement: $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r11) 
 ; Statement: if $z3 == 0 goto (branch) 
(assert (= (ite var142 1 0) 0)) ; Cond: $z3 == 0 
 ; Statement: if z4 == 0 goto r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>() 
(assert (not (= (ite var1287 1 0) 0))) ; Negate: Cond: z4 == 0  
(assert true)
(define-const var62 String (getServiceKey/1456125852 var3595)) ; Statement: r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>() 
 ; Statement: goto [?= $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12)] 
(assert true) ; Non Conditional
(define-const var3451 Bool (var2427_isNotEmpty/-1251449450 var62)) ; Statement: $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12) 
 ; Statement: if $z5 == 0 goto (branch) 
(assert (= (ite var3451 1 0) 0)) ; Cond: $z5 == 0 
 ; Statement: if z6 == 0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= (ite var3404 1 0) 0)) ; Cond: z6 == 0 
(assert true)
(define-const var2981 String (toString/-2075883882 var2059!1)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getProtocol/491749358=([org.apache.dubbo.common.URL], java.lang.String), var2427_isNotEmpty/-1251449450=([java.lang.String], boolean), urlAddress/1606454354=([org.apache.dubbo.common.URL], org.apache.dubbo.common.url.component.URLAddress), getIp/116471783=([org.apache.dubbo.common.url.component.URLAddress], java.lang.String), getServiceKey/1456125852=([org.apache.dubbo.common.URL], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2578=org.apache.dubbo.common.URL, var3595=r1, var2373=z1, var3404=z6, var75=z2, var1287=z4, var1242=r4, var2059=$r0, var1722=$r2, var2427=org.apache.dubbo.common.utils.StringUtils, var3175=$z0, var3146=org.apache.dubbo.common.url.component.URLAddress, var1564=$r5, var1486=r11, var142=$z3, var62=r12, var3451=$z5, var2981=$r3}
; {org.apache.dubbo.common.URL=var2578, r1=var3595, z1=var2373, z6=var3404, z2=var75, z4=var1287, r4=var1242, $r0=var2059, $r2=var1722, org.apache.dubbo.common.utils.StringUtils=var2427, $z0=var3175, org.apache.dubbo.common.url.component.URLAddress=var3146, $r5=var1564, r11=var1486, $z3=var142, r12=var62, $z5=var3451, $r3=var2981}
;seq <java.lang.StringBuilder: void <init>()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	z1 := @parameter0: boolean;	z6 := @parameter1: boolean;	z2 := @parameter2: boolean;	z4 := @parameter3: boolean;	r4 := @parameter4: java.lang.String[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getProtocol()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r2);	if $z0 == 0 goto (branch);	if z1 == 0 goto (branch);	if z2 == 0 goto r11 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getHost()>();	$r5 = r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.url.component.URLAddress urlAddress>;	r11 = virtualinvoke $r5.<org.apache.dubbo.common.url.component.URLAddress: java.lang.String getIp()>();	goto [?= $z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r11)];	$z3 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r11);	if $z3 == 0 goto (branch);	if z4 == 0 goto r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getPath()>();	r12 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String getServiceKey()>();	goto [?= $z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12)];	$z5 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r12);	if $z5 == 0 goto (branch);	if z6 == 0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 10