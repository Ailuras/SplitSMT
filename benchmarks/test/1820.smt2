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

(declare-sort var1514 0)
(declare-sort var2256 0)
(declare-sort var2770 0)
(declare-sort var3026 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2770_isNotEmpty/-1251449450 (String) Bool)
(declare-const null-var1514 var1514)
(declare-const null-String String)
(declare-const null-var3026 var3026)
(declare-const var2008 var1514) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToDurationConverter 
(assert (not (= var2008 null-var1514)))
(declare-const var210 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var210 null-String)))
(define-const var155 Bool (var2770_isNotEmpty/-1251449450 var210)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (= (ite var155 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1154 var3026 null-var3026) ; Statement: $r2 = null 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var2770_isNotEmpty/-1251449450=([java.lang.String], boolean)}
; {var1514=org.apache.dubbo.common.convert.StringToDurationConverter, var2008=r1, var210=r0, var2256=null_type, var2770=org.apache.dubbo.common.utils.StringUtils, var155=$z0, var3026=java.time.Duration, var1154=$r2}
; {org.apache.dubbo.common.convert.StringToDurationConverter=var1514, r1=var2008, r0=var210, null_type=var2256, org.apache.dubbo.common.utils.StringUtils=var2770, $z0=var155, java.time.Duration=var3026, $r2=var1154}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToDurationConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = null;	return $r2
;block_num 3