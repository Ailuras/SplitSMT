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

(declare-sort var3176 0)
(declare-sort var2938 0)
(declare-sort var1620 0)
(declare-sort var2400 0)
(declare-sort var835 0)
(declare-sort var1239 0)
(declare-sort var2966 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceNumbers/-749907006 (var3176 String) var1620)
(declare-fun var1620_get/1088891777 (var1620 var2400) var2400)
(declare-fun cast-from-String-to-var2400 (String) var2400)
(declare-fun cast-from-var2400-to-var835 (var2400) var835)
(declare-fun getServiceParameter/1782298180 (var1239 String String) String)
(declare-fun cast-from-var3176-to-var1239 (var3176) var1239)
(declare-fun var2966_isEmpty/-813097145 (String) Bool)
(declare-fun Float64_parseDouble/1471110886 (String) Float64)
(declare-fun getNumbers/1837151550 (var3176) var1620)
(declare-fun Float64_valueOf/679560954 (Float64) Float64)
(declare-fun var1620_put/1464166817 (var1620 var2400 var2400) var2400)
(declare-fun cast-from-Float64-to-var2400 (Float64) var2400)
(declare-const null-var3176 var3176)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const null-var835 var835)
(declare-const var271 var3176) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert (not (= var271 null-var3176)))
(declare-const var2492 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2492 null-String)))
(declare-const var986 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var986 null-String)))
(declare-const var1874 Float64) ; Statement: d1 := @parameter2: double 
(assert (not (= var1874 null-Float64)))
(assert true)
(define-const var826 var1620 (getServiceNumbers/-749907006 var271 var2492)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.util.Map getServiceNumbers(java.lang.String)>(r1) 
(define-const var1980 var2400 (var1620_get/1088891777 var826 (cast-from-String-to-var2400 var986))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2) 
(define-const var2708 var835 (cast-from-var2400-to-var835 var1980)) ; Statement: r5 = (java.lang.Number) $r4 
 ; Statement: if r5 == null goto r6 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(assert (= var2708 null-var835)) ; Cond: r5 == null 
(assert true)
(define-const var3887 String (getServiceParameter/1782298180 (cast-from-var3176-to-var1239 var271) var2492 var986)) ; Statement: r6 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var412 Bool (var2966_isEmpty/-813097145 var3887)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r6) 
 ; Statement: if $z0 == 0 goto d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r6) 
(assert (= (ite var412 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3894 Float64 (Float64_parseDouble/1471110886 var3887)) ; Statement: d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r6) 
(assert true)
(define-const var105 var1620 (getNumbers/1837151550 var271)) ; Statement: $r8 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.util.Map getNumbers()>() 
(define-const var1089 Float64 (Float64_valueOf/679560954 var3894)) ; Statement: $r7 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d0) 
;(assert (var1620_put/1464166817 var105 (cast-from-String-to-var2400 var986) (cast-from-Float64-to-var2400 var1089))) ; Statement: interfaceinvoke $r8.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r2, $r7) 

(declare-const var105!1 var1620)
(declare-const var986!1 String)
(declare-const var1089!1 Float64)
 ; Statement: return d0 
(check-sat)
; {getServiceNumbers/-749907006=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String], java.util.Map), var1620_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2400=([java.lang.String], java.lang.Object), cast-from-var2400-to-var835=([java.lang.Object], java.lang.Number), getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), cast-from-var3176-to-var1239=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), var2966_isEmpty/-813097145=([java.lang.String], boolean), Float64_parseDouble/1471110886=([java.lang.String], double), getNumbers/1837151550=([org.apache.dubbo.common.url.component.ServiceConfigURL], java.util.Map), Float64_valueOf/679560954=([double], java.lang.Double), var1620_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-Float64-to-var2400=([java.lang.Double], java.lang.Object)}
; {var3176=org.apache.dubbo.common.url.component.ServiceConfigURL, var271=r0, var2492=r1, var2938=null_type, var986=r2, var1874=d1, var1620=java.util.Map, var826=$r3, var2400=java.lang.Object, var1980=$r4, var835=java.lang.Number, var2708=r5, var1239=org.apache.dubbo.common.URL, var3887=r6, var2966=org.apache.dubbo.common.utils.StringUtils, var412=$z0, var3894=d0, var105=$r8, var1089=$r7}
; {org.apache.dubbo.common.url.component.ServiceConfigURL=var3176, r0=var271, r1=var2492, null_type=var2938, r2=var986, d1=var1874, java.util.Map=var1620, $r3=var826, java.lang.Object=var2400, $r4=var1980, java.lang.Number=var835, r5=var2708, org.apache.dubbo.common.URL=var1239, r6=var3887, org.apache.dubbo.common.utils.StringUtils=var2966, $z0=var412, d0=var3894, $r8=var105, $r7=var1089}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.ServiceConfigURL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	d1 := @parameter2: double;	$r3 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.util.Map getServiceNumbers(java.lang.String)>(r1);	$r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2);	r5 = (java.lang.Number) $r4;	if r5 == null goto r6 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	r6 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r6);	if $z0 == 0 goto d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r6);	d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r6);	$r8 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.util.Map getNumbers()>();	$r7 = staticinvoke <java.lang.Double: java.lang.Double valueOf(double)>(d0);	interfaceinvoke $r8.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r2, $r7);	return d0
;block_num 3