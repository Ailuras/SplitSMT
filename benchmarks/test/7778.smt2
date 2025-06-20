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

(declare-sort var797 0)
(declare-sort var1818 0)
(declare-sort var339 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun id/-1864662359 (var797) String)
(declare-fun var339_isEmpty/-813097145 (String) Bool)
(declare-const null-var797 var797)
(declare-const null-var1818 var1818)
(declare-const var783 var797) ; Statement: r0 := @this: org.apache.dubbo.config.bootstrap.builders.AbstractBuilder 
(assert (not (= var783 null-var797)))
(declare-const var717 var1818) ; Statement: r2 := @parameter0: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var717 null-var1818)))
(define-const var951 String (id/-1864662359 var783)) ; Statement: $r1 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractBuilder: java.lang.String id> 
(define-const var1520 Bool (var339_isEmpty/-813097145 var951)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1) 
 ; Statement: if $z0 != 0 goto return 
(assert (not (= (ite var1520 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return 
(check-sat)
; {id/-1864662359=([org.apache.dubbo.config.bootstrap.builders.AbstractBuilder], java.lang.String), var339_isEmpty/-813097145=([java.lang.String], boolean)}
; {var797=org.apache.dubbo.config.bootstrap.builders.AbstractBuilder, var783=r0, var1818=org.apache.dubbo.config.AbstractConfig, var717=r2, var951=$r1, var339=org.apache.dubbo.common.utils.StringUtils, var1520=$z0}
; {org.apache.dubbo.config.bootstrap.builders.AbstractBuilder=var797, r0=var783, org.apache.dubbo.config.AbstractConfig=var1818, r2=var717, $r1=var951, org.apache.dubbo.common.utils.StringUtils=var339, $z0=var1520}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.bootstrap.builders.AbstractBuilder;	r2 := @parameter0: org.apache.dubbo.config.AbstractConfig;	$r1 = r0.<org.apache.dubbo.config.bootstrap.builders.AbstractBuilder: java.lang.String id>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>($r1);	if $z0 != 0 goto return;	return
;block_num 2