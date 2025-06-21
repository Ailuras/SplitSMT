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

(declare-sort var3906 0)
(declare-sort var765 0)
(declare-sort var74 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var74_isNotEmpty/-1251449450 (String) Bool)
(declare-fun Int_valueOf/1446997944 (String) Int)
(declare-const null-var3906 var3906)
(declare-const null-String String)
(declare-const var2820 var3906) ; Statement: r1 := @this: org.apache.dubbo.common.convert.StringToLongConverter 
(assert (not (= var2820 null-var3906)))
(declare-const var943 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var943 null-String)))
(define-const var3819 Bool (var74_isNotEmpty/-1251449450 var943)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = null 
(assert (not (= (ite var3819 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2113 Int (Int_valueOf/1446997944 var943)) ; Statement: $r2 = staticinvoke <java.lang.Long: java.lang.Long valueOf(java.lang.String)>(r0) 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var74_isNotEmpty/-1251449450=([java.lang.String], boolean), Int_valueOf/1446997944=([java.lang.String], java.lang.Long)}
; {var3906=org.apache.dubbo.common.convert.StringToLongConverter, var2820=r1, var943=r0, var765=null_type, var74=org.apache.dubbo.common.utils.StringUtils, var3819=$z0, var2113=$r2}
; {org.apache.dubbo.common.convert.StringToLongConverter=var3906, r1=var2820, r0=var943, null_type=var765, org.apache.dubbo.common.utils.StringUtils=var74, $z0=var3819, $r2=var2113}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.convert.StringToLongConverter;	r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = null;	$r2 = staticinvoke <java.lang.Long: java.lang.Long valueOf(java.lang.String)>(r0);	goto [?= return $r2];	return $r2
;block_num 3