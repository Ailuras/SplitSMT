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

(declare-sort var1269 0)
(declare-sort var1935 0)
(declare-sort var422 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun id/-1864662359 (var1269) String)
(declare-fun var422_isEmpty/-813097145 (String) Bool)
(declare-fun setId/369852133 (var1935 String) void)
(declare-const null-var1269 var1269)
(declare-const null-var1935 var1935)
(declare-const var3325 var1269) ; Statement: r0 := @this: org.apache.dubbo.config.bootstrap.builders.AbstractBuilder 
(assert (not (= var3325 null-var1269)))
(declare-const var604 var1935) ; Statement: r2 := @parameter0: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var604 null-var1935)))
(define-const var2849 String (id/-1864662359 var3325)) ; Statement: $r1 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractBuilder: java.lang.String id> 
(define-const var2744 Bool (var422_isEmpty/-813097145 var2849)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 != 0 goto return 
(assert (not (not (= (ite var2744 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2455 String (id/-1864662359 var3325)) ; Statement: $r3 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractBuilder: java.lang.String id> 
(assert true)
;(assert (setId/369852133 var604 var2455)) ; Statement: virtualinvoke r2.<org.apache.dubbo.config.AbstractConfig: void setId(java.lang.String)>($r3) 

(declare-const var604!1 var1935)
(declare-const var2455!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {id/-1864662359=([org.apache.dubbo.config.bootstrap.builders.AbstractBuilder], java.lang.String), var422_isEmpty/-813097145=([java.lang.String], boolean), setId/369852133=([org.apache.dubbo.config.AbstractConfig, java.lang.String], void)}
; {var1269=org.apache.dubbo.config.bootstrap.builders.AbstractBuilder, var3325=r0, var1935=org.apache.dubbo.config.AbstractConfig, var604=r2, var2849=$r1, var422=org.apache.dubbo.common.utils.StringUtils, var2744=$z0, var2455=$r3}
; {org.apache.dubbo.config.bootstrap.builders.AbstractBuilder=var1269, r0=var3325, org.apache.dubbo.config.AbstractConfig=var1935, r2=var604, $r1=var2849, org.apache.dubbo.common.utils.StringUtils=var422, $z0=var2744, $r3=var2455}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.bootstrap.builders.AbstractBuilder;	r2 := @parameter0: org.apache.dubbo.config.AbstractConfig;	$r1 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractBuilder: java.lang.String id>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 != 0 goto return;	$r3 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractBuilder: java.lang.String id>;	virtualinvoke r2.<org.apache.dubbo.config.AbstractConfig: void setId(java.lang.String)>($r3);	return
;block_num 3