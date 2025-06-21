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

(declare-sort var2734 0)
(declare-sort var1125 0)
(declare-sort var2045 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1125_isEmpty/-813097145 (String) Bool)
(declare-fun var2045-init () var2045)
(declare-fun <init>/-201242697 (var2045) void)
(declare-const null-String String)
(declare-const var681 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var681 null-String)))
(define-const var2587 Bool (var1125_isEmpty/-813097145 var681)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseKeyValuePair(java.lang.String,java.lang.String)>(r0, "\\&") 
(assert (not (= (ite var2587 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2178 var2045 var2045-init) ; Statement: $r2 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2178)) ; Statement: specialinvoke $r2.<java.util.HashMap: void <init>()>() 

(declare-const var2178!1 var2045)
 ; Statement: return $r2 
(check-sat)
; {var1125_isEmpty/-813097145=([java.lang.String], boolean), var2045-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void)}
; {var681=r0, var2734=null_type, var1125=org.apache.dubbo.common.utils.StringUtils, var2587=$z0, var2045=java.util.HashMap, var2178=$r2}
; {r0=var681, null_type=var2734, org.apache.dubbo.common.utils.StringUtils=var1125, $z0=var2587, java.util.HashMap=var2045, $r2=var2178}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.Map parseKeyValuePair(java.lang.String,java.lang.String)>(r0, "\\&");	$r2 = new java.util.HashMap;	specialinvoke $r2.<java.util.HashMap: void <init>()>();	return $r2
;block_num 2