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

(declare-sort var3343 0)
(declare-sort var1384 0)
(declare-sort var203 0)
(declare-sort var2625 0)
(declare-sort var641 0)
(declare-sort var1739 0)
(declare-sort var186 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceNumbers/-749907006 (var3343 String) var203)
(declare-fun var203_get/1088891777 (var203 var2625) var2625)
(declare-fun cast-from-String-to-var2625 (String) var2625)
(declare-fun cast-from-var2625-to-var641 (var2625) var641)
(declare-fun getServiceParameter/1782298180 (var1739 String String) String)
(declare-fun cast-from-var3343-to-var1739 (var3343) var1739)
(declare-fun var186_isEmpty/-813097145 (String) Bool)
(declare-const null-var3343 var3343)
(declare-const null-String String)
(declare-const null-Float64 Float64)
(declare-const null-var641 var641)
(declare-const var2820 var3343) ; Statement: r0 := @this: org.apache.dubbo.common.url.component.ServiceConfigURL 
(assert (not (= var2820 null-var3343)))
(declare-const var280 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var280 null-String)))
(declare-const var2989 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2989 null-String)))
(declare-const var1784 Float64) ; Statement: d1 := @parameter2: double 
(assert (not (= var1784 null-Float64)))
(assert true)
(define-const var1177 var203 (getServiceNumbers/-749907006 var2820 var280)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.util.Map getServiceNumbers(java.lang.String)>(r1) 
(define-const var1353 var2625 (var203_get/1088891777 var1177 (cast-from-String-to-var2625 var2989))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2) 
(define-const var1694 var641 (cast-from-var2625-to-var641 var1353)) ; Statement: r5 = (java.lang.Number) $r4 
 ; Statement: if r5 == null goto r6 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(assert (= var1694 null-var641)) ; Cond: r5 == null 
(assert true)
(define-const var2701 String (getServiceParameter/1782298180 (cast-from-var3343-to-var1739 var2820) var280 var2989)) ; Statement: r6 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2811 Bool (var186_isEmpty/-813097145 var2701)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r6) 
 ; Statement: if $z0 == 0 goto d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r6) 
(assert (not (= (ite var2811 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return d1 
(check-sat)
; {getServiceNumbers/-749907006=([org.apache.dubbo.common.url.component.ServiceConfigURL, java.lang.String], java.util.Map), var203_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-String-to-var2625=([java.lang.String], java.lang.Object), cast-from-var2625-to-var641=([java.lang.Object], java.lang.Number), getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), cast-from-var3343-to-var1739=([org.apache.dubbo.common.url.component.ServiceConfigURL], org.apache.dubbo.common.URL), var186_isEmpty/-813097145=([java.lang.String], boolean)}
; {var3343=org.apache.dubbo.common.url.component.ServiceConfigURL, var2820=r0, var280=r1, var1384=null_type, var2989=r2, var1784=d1, var203=java.util.Map, var1177=$r3, var2625=java.lang.Object, var1353=$r4, var641=java.lang.Number, var1694=r5, var1739=org.apache.dubbo.common.URL, var2701=r6, var186=org.apache.dubbo.common.utils.StringUtils, var2811=$z0}
; {org.apache.dubbo.common.url.component.ServiceConfigURL=var3343, r0=var2820, r1=var280, null_type=var1384, r2=var2989, d1=var1784, java.util.Map=var203, $r3=var1177, java.lang.Object=var2625, $r4=var1353, java.lang.Number=var641, r5=var1694, org.apache.dubbo.common.URL=var1739, r6=var2701, org.apache.dubbo.common.utils.StringUtils=var186, $z0=var2811}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.url.component.ServiceConfigURL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	d1 := @parameter2: double;	$r3 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.util.Map getServiceNumbers(java.lang.String)>(r1);	$r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2);	r5 = (java.lang.Number) $r4;	if r5 == null goto r6 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	r6 = virtualinvoke r0.<org.apache.dubbo.common.url.component.ServiceConfigURL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r6);	if $z0 == 0 goto d0 = staticinvoke <java.lang.Double: double parseDouble(java.lang.String)>(r6);	return d1
;block_num 3