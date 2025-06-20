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

(declare-sort var618 0)
(declare-sort var3268 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun setProtocol/-9870350 (var3268 String) var3268)
(declare-fun arr-String-init () (Array Int String))
(declare-fun String_valueOf/-1973653463 (Bool) String)
(declare-fun addParameters/1592766819 (var3268 (Array Int String)) var3268)
(declare-const null-var618 var618)
(declare-const null-var3268 var3268)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var528 var618) ; Statement: r5 := @this: org.apache.dubbo.registry.integration.RegistryProtocol 
(assert (not (= var528 null-var618)))
(declare-const var3591 var3268) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3591 null-var3268)))
(assert true)
(define-const var2401 var3268 (setProtocol/-9870350 var3591 "provider")) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setProtocol(java.lang.String)>("provider") 
(define-const var2175 (Array Int String) arr-String-init) ; Statement: $r1 = newarray (java.lang.String)[4] 
(declare-const var2175!1 (Array Int String))
(assert (not (= var2175!1 null-__Array__Int__String__)))
(assert (= (select var2175!1 0) "category")) ; Statement: $r1[0] = "category" 
(declare-const var2175!2 (Array Int String))
(assert (not (= var2175!2 null-__Array__Int__String__)))
(assert (= (select var2175!2 1) "configurators")) ; Statement: $r1[1] = "configurators" 
(declare-const var2175!3 (Array Int String))
(assert (not (= var2175!3 null-__Array__Int__String__)))
(assert (= (select var2175!3 2) "check")) ; Statement: $r1[2] = "check" 
(define-const var3391 String (String_valueOf/-1973653463 (ite (= 1 0) true false))) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0) 
(declare-const var2175!4 (Array Int String))
(assert (not (= var2175!4 null-__Array__Int__String__)))
(assert (= (select var2175!4 3) var3391)) ; Statement: $r1[3] = $r2 
(assert true)
(define-const var3417 var3268 (addParameters/1592766819 var2401 var2175!4)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameters(java.lang.String[])>($r1) 
 ; Statement: return $r4 
(check-sat)
; {setProtocol/-9870350=([org.apache.dubbo.common.URL, java.lang.String], org.apache.dubbo.common.URL), arr-String-init=([], java.lang.String[]), String_valueOf/-1973653463=([boolean], java.lang.String), addParameters/1592766819=([org.apache.dubbo.common.URL, java.lang.String[]], org.apache.dubbo.common.URL)}
; {var618=org.apache.dubbo.registry.integration.RegistryProtocol, var528=r5, var3268=org.apache.dubbo.common.URL, var3591=r0, var2401=$r3, var2175=$r1, var3391=$r2, var3417=$r4}
; {org.apache.dubbo.registry.integration.RegistryProtocol=var618, r5=var528, org.apache.dubbo.common.URL=var3268, r0=var3591, $r3=var2401, $r1=var2175, $r2=var3391, $r4=var3417}
;seq <java.lang.String: java.lang.String valueOf(boolean)>
;cnt {"<java.lang.String: java.lang.String valueOf(boolean)>": 1}
;stmts r5 := @this: org.apache.dubbo.registry.integration.RegistryProtocol;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL setProtocol(java.lang.String)>("provider");	$r1 = newarray (java.lang.String)[4];	$r1[0] = "category";	$r1[1] = "configurators";	$r1[2] = "check";	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(boolean)>(0);	$r1[3] = $r2;	$r4 = virtualinvoke $r3.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameters(java.lang.String[])>($r1);	return $r4
;block_num 1