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

(declare-sort var3253 0)
(declare-sort var2471 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2471_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var2471-SLASH String)
(declare-const var2492 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2492 null-String)))
(define-const var3333 Bool (var2471_isEmpty/-813097145 var2492)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto r3 = r0 
(assert (not (= (ite var3333 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var275 String var2471-SLASH) ; Statement: $r2 = <org.apache.dubbo.common.utils.StringUtils: java.lang.String SLASH> 
 ; Statement: return $r2 
(check-sat)
; {var2471_isEmpty/-813097145=([java.lang.String], boolean)}
; {var2492=r0, var3253=null_type, var2471=org.apache.dubbo.common.utils.StringUtils, var3333=$z0, var275=$r2}
; {r0=var2492, null_type=var3253, org.apache.dubbo.common.utils.StringUtils=var2471, $z0=var3333, $r2=var275}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto r3 = r0;	$r2 = <org.apache.dubbo.common.utils.StringUtils: java.lang.String SLASH>;	return $r2
;block_num 2