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

(declare-sort var2343 0)
(declare-sort var702 0)
(declare-sort var2661 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2661_isNotEmpty/-1251449450 (String) Bool)
(declare-fun toCharArray/415275702 (String) (Array Int Int))
(declare-const null-var2343 var2343)
(declare-const null-String String)
(declare-const var2529 var2343) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToCharArrayConverter 
(assert (not (= var2529 null-var2343)))
(declare-const var3016 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3016 null-String)))
(define-const var3195 Bool (var2661_isNotEmpty/-1251449450 var3016)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (not (= (ite var3195 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var401 (Array Int Int) (toCharArray/415275702 var3016)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: char[] toCharArray()>() 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var2661_isNotEmpty/-1251449450=([java.lang.String], boolean), toCharArray/415275702=([java.lang.String], char[])}
; {var2343=org.apache.dubbo.common.convert.StringToCharArrayConverter, var2529=r1, var3016=r0, var702=null_type, var2661=org.apache.dubbo.common.utils.StringUtils, var3195=$z0, var401=$r2}
; {org.apache.dubbo.common.convert.StringToCharArrayConverter=var2343, r1=var2529, r0=var3016, null_type=var702, org.apache.dubbo.common.utils.StringUtils=var2661, $z0=var3195, $r2=var401}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.String: char[] toCharArray()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.String: char[] toCharArray()>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToCharArrayConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = virtualinvoke r0.<java.lang.String: char[] toCharArray()>();	goto [?= return $r2];	return $r2
;block_num 3