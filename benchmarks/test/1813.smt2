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

(declare-sort var2372 0)
(declare-sort var2189 0)
(declare-sort var1652 0)
(declare-sort var2318 0)
(declare-sort var1897 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1652_isNotEmpty/-1251449450 (String) Bool)
(declare-fun var1897_detectAndParse/1748146615 (String) var2318)
(declare-const null-var2372 var2372)
(declare-const null-String String)
(declare-const var716 var2372) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToDurationConverter 
(assert (not (= var716 null-var2372)))
(declare-const var3466 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3466 null-String)))
(define-const var1648 Bool (var1652_isNotEmpty/-1251449450 var3466)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (not (= (ite var1648 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1997 var2318 (var1897_detectAndParse/1748146615 var3466)) ; Statement: $r2 = staticinvoke <org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle: java.time.Duration detectAndParse(java.lang.String)>(r0) 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var1652_isNotEmpty/-1251449450=([java.lang.String], boolean), var1897_detectAndParse/1748146615=([java.lang.String], java.time.Duration)}
; {var2372=org.apache.dubbo.common.convert.StringToDurationConverter, var716=r1, var3466=r0, var2189=null_type, var1652=org.apache.dubbo.common.utils.StringUtils, var1648=$z0, var2318=java.time.Duration, var1897=org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle, var1997=$r2}
; {org.apache.dubbo.common.convert.StringToDurationConverter=var2372, r1=var716, r0=var3466, null_type=var2189, org.apache.dubbo.common.utils.StringUtils=var1652, $z0=var1648, java.time.Duration=var2318, org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle=var1897, $r2=var1997}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToDurationConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = staticinvoke <org.apache.dubbo.common.convert.StringToDurationConverter$DurationStyle: java.time.Duration detectAndParse(java.lang.String)>(r0);	goto [?= return $r2];	return $r2
;block_num 3