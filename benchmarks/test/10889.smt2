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

(declare-sort var622 0)
(declare-sort var3910 0)
(declare-sort var2216 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getApplication/-536601276 (var622) String)
(declare-fun var2216_isEmpty/-813097145 (String) Bool)
(declare-const null-var622 var622)
(declare-const null-String String)
(declare-const var588 var622) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var588 null-var622)))
(declare-const var3952 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3952 null-String)))
(assert true)
(define-const var45 String (getApplication/-536601276 var588)) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getApplication()>() 
(define-const var2037 Bool (var2216_isEmpty/-813097145 var45)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = r1 
(assert (= (ite var2037 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1193 String var45) ; Statement: $r3 = r1 
(assert true) ; Non Conditional
 ; Statement: return $r3 
(check-sat)
; {getApplication/-536601276=([org.apache.dubbo.common.URL], java.lang.String), var2216_isEmpty/-813097145=([java.lang.String], boolean)}
; {var622=org.apache.dubbo.common.URL, var588=r0, var3952=r2, var3910=null_type, var45=r1, var2216=org.apache.dubbo.common.utils.StringUtils, var2037=$z0, var1193=$r3}
; {org.apache.dubbo.common.URL=var622, r0=var588, r2=var3952, null_type=var3910, r1=var45, org.apache.dubbo.common.utils.StringUtils=var2216, $z0=var2037, $r3=var1193}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getApplication()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r3 = r1;	$r3 = r1;	return $r3
;block_num 3