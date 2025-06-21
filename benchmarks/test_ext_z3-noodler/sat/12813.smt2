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

(declare-sort var471 0)
(declare-sort var1347 0)
(declare-sort var2118 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceParameter/1782298180 (var471 String String) String)
(declare-fun var2118_isEmpty/-813097145 (String) Bool)
(declare-fun Int_parseShort/65208931 (String) Int)
(declare-const null-var471 var471)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1433 var471) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1433 null-var471)))
(declare-const var2522 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2522 null-String)))
(declare-const var3733 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3733 null-String)))
(declare-const var2550 Int) ; Statement: s1 := @parameter2: short 
(assert (not (= var2550 null-Int)))
(assert true)
(define-const var2508 String (getServiceParameter/1782298180 var1433 var2522 var3733)) ; Statement: r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2) 
(define-const var2220 Bool (var2118_isEmpty/-813097145 var2508)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r3) 
(assert (= (ite var2220 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3651 Int (Int_parseShort/65208931 var2508)) ; Statement: $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r3) 
 ; Statement: return $s0 
(check-sat)
; {getServiceParameter/1782298180=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), var2118_isEmpty/-813097145=([java.lang.String], boolean), Int_parseShort/65208931=([java.lang.String], short)}
; {var471=org.apache.dubbo.common.URL, var1433=r0, var2522=r1, var1347=null_type, var3733=r2, var2550=s1, var2508=r3, var2118=org.apache.dubbo.common.utils.StringUtils, var2220=$z0, var3651=$s0}
; {org.apache.dubbo.common.URL=var471, r0=var1433, r1=var2522, null_type=var1347, r2=var3733, s1=var2550, r3=var2508, org.apache.dubbo.common.utils.StringUtils=var2118, $z0=var2220, $s0=var3651}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	s1 := @parameter2: short;	r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getServiceParameter(java.lang.String,java.lang.String)>(r1, r2);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r3);	if $z0 == 0 goto $s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r3);	$s0 = staticinvoke <java.lang.Short: short parseShort(java.lang.String)>(r3);	return $s0
;block_num 2