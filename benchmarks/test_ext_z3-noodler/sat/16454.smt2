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

(declare-sort var1770 0)
(declare-sort var289 0)
(declare-sort var752 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun consumerParamFirst/5744255 (var1770 String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getProtocolServiceKey/574559726 (var1770) String)
(declare-fun var752_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1770 var1770)
(declare-const null-String String)
(declare-const var56 var1770) ; Statement: r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL 
(assert (not (= var56 null-var1770)))
(declare-const var2049 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2049 null-String)))
(assert true)
(define-const var3430 Bool (consumerParamFirst/5744255 var56 var2049)) ; Statement: $z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r12 = new java.lang.StringBuilder 
(assert (= (ite var3430 1 0) 0)) ; Cond: $z0 == 0 
(define-const var566 String String-init) ; Statement: $r12 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var566)) ; Statement: specialinvoke $r12.<java.lang.StringBuilder: void <init>()>() 
(declare-const var566!1 String)
(assert (= var566!1 ""))
(assert true)
(define-const var883 String (append/672562846 var566!1 ".")) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var566!2 String)
(assert (= var566!2 (str.++ var566!1 ".")))
(assert true)
(define-const var1240 String (append/672562846 var883 var2049)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var883!1 String)
(assert (= var883!1 (str.++ var883 var2049)))
(assert true)
(define-const var1119 String (toString/-2075883882 var1240)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var806 String (getProtocolServiceKey/574559726 var56)) ; Statement: $r16 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>() 
(define-const var373 Bool (var752_isNotEmpty/-1251449450 var806)) ; Statement: $z4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r16) 
 ; Statement: if $z4 == 0 goto return null 
(assert (= (ite var373 1 0) 0)) ; Cond: $z4 == 0 
 ; Statement: return null 
(check-sat)
; {consumerParamFirst/5744255=([org.apache.dubbo.registry.client.InstanceAddressURL, java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getProtocolServiceKey/574559726=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), var752_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1770=org.apache.dubbo.registry.client.InstanceAddressURL, var56=r0, var2049=r1, var289=null_type, var3430=$z0, var566=$r12, var883=$r13, var1240=$r14, var1119=$r15, var806=$r16, var752=org.apache.dubbo.common.utils.StringUtils, var373=$z4}
; {org.apache.dubbo.registry.client.InstanceAddressURL=var1770, r0=var56, r1=var2049, null_type=var289, $z0=var3430, $r12=var566, $r13=var883, $r14=var1240, $r15=var1119, $r16=var806, org.apache.dubbo.common.utils.StringUtils=var752, $z4=var373}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.client.InstanceAddressURL;	r1 := @parameter0: java.lang.String;	$z0 = specialinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: boolean consumerParamFirst(java.lang.String)>(r1);	if $z0 == 0 goto $r12 = new java.lang.StringBuilder;	$r12 = new java.lang.StringBuilder;	specialinvoke $r12.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r15 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.String toString()>();	$r16 = virtualinvoke r0.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String getProtocolServiceKey()>();	$z4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r16);	if $z4 == 0 goto return null;	return null
;block_num 3