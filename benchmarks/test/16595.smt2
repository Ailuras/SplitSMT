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

(declare-sort var2109 0)
(declare-sort var2394 0)
(declare-sort var468 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun originUrl/-420841356 (var2109) var2394)
(declare-fun toString/-634963160 (var2394) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun overrideParams/-420841356 (var2109) var468)
(declare-fun toString/-950398813 (var468) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2109 var2109)
(declare-const var836 var2109) ; Statement: r1 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL 
(assert (not (= var836 null-var2109)))
(define-const var714 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var714)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var714!1 String)
(assert (= var714!1 ""))
(define-const var3289 var2394 (originUrl/-420841356 var836)) ; Statement: $r2 = r1.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl> 
(assert true)
(define-const var2584 String (toString/-634963160 var3289)) ; Statement: $r3 = virtualinvoke $r2.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String toString()>() 
(assert true)
(define-const var2157 String (append/672562846 var714!1 var2584)) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var714!2 String)
(assert (= var714!2 (str.++ var714!1 var2584)))
(assert true)
(define-const var724 String (append/672562846 var2157 ", overrideParams: ")) ; Statement: $r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", overrideParams: ") 
(declare-const var2157!1 String)
(assert (= var2157!1 (str.++ var2157 ", overrideParams: ")))
(define-const var3888 var468 (overrideParams/-420841356 var836)) ; Statement: $r5 = r1.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams> 
(assert true)
(define-const var1170 String (toString/-950398813 var3888)) ; Statement: $r6 = virtualinvoke $r5.<org.apache.dubbo.common.url.component.URLParam: java.lang.String toString()>() 
(assert true)
(define-const var3512 String (append/672562846 var724 var1170)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var724!1 String)
(assert (= var724!1 (str.++ var724 var1170)))
(assert true)
(define-const var2408 String (toString/-2075883882 var3512)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r9 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), originUrl/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.registry.client.InstanceAddressURL), toString/-634963160=([org.apache.dubbo.registry.client.InstanceAddressURL], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), overrideParams/-420841356=([org.apache.dubbo.registry.client.OverrideInstanceAddressURL], org.apache.dubbo.common.url.component.URLParam), toString/-950398813=([org.apache.dubbo.common.url.component.URLParam], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2109=org.apache.dubbo.registry.client.OverrideInstanceAddressURL, var836=r1, var714=$r0, var2394=org.apache.dubbo.registry.client.InstanceAddressURL, var3289=$r2, var2584=$r3, var2157=$r4, var724=$r7, var468=org.apache.dubbo.common.url.component.URLParam, var3888=$r5, var1170=$r6, var3512=$r8, var2408=$r9}
; {org.apache.dubbo.registry.client.OverrideInstanceAddressURL=var2109, r1=var836, $r0=var714, org.apache.dubbo.registry.client.InstanceAddressURL=var2394, $r2=var3289, $r3=var2584, $r4=var2157, $r7=var724, org.apache.dubbo.common.url.component.URLParam=var468, $r5=var3888, $r6=var1170, $r8=var3512, $r9=var2408}
;seq <java.lang.StringBuilder: void <init>()>;	<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<org.apache.dubbo.common.url.component.URLParam: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.client.OverrideInstanceAddressURL;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.registry.client.InstanceAddressURL originUrl>;	$r3 = virtualinvoke $r2.<org.apache.dubbo.registry.client.InstanceAddressURL: java.lang.String toString()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", overrideParams: ");	$r5 = r1.<org.apache.dubbo.registry.client.OverrideInstanceAddressURL: org.apache.dubbo.common.url.component.URLParam overrideParams>;	$r6 = virtualinvoke $r5.<org.apache.dubbo.common.url.component.URLParam: java.lang.String toString()>();	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.String toString()>();	return $r9
;block_num 1