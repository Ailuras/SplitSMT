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

(declare-sort var2884 0)
(declare-sort var3761 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3761_matchIpRange/172324597 (String String Int) Bool)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2090 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2090 null-String)))
(declare-const var1518 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1518 null-String)))
(declare-const var2019 Int) ; Statement: i0 := @parameter2: int 
(assert (not (= var2019 null-Int)))
(assert true)
(define-const var2166 Bool (contains/1009244746 var2090 (cast-from-String-to-String "/"))) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("/") 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean matchIpRange(java.lang.String,java.lang.String,int)>(r0, r1, i0) 
(assert (= (ite var2166 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3316 Bool (var3761_matchIpRange/172324597 var2090 var1518 var2019)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean matchIpRange(java.lang.String,java.lang.String,int)>(r0, r1, i0) 
 ; Statement: return $z1 
(check-sat)
; {contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3761_matchIpRange/172324597=([java.lang.String, java.lang.String, int], boolean)}
; {var2090=r0, var2884=null_type, var1518=r1, var2019=i0, var2166=$z0, var3761=org.apache.dubbo.common.utils.NetUtils, var3316=$z1}
; {r0=var2090, null_type=var2884, r1=var1518, i0=var2019, $z0=var2166, org.apache.dubbo.common.utils.NetUtils=var3761, $z1=var3316}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	i0 := @parameter2: int;	$z0 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("/");	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean matchIpRange(java.lang.String,java.lang.String,int)>(r0, r1, i0);	$z1 = staticinvoke <org.apache.dubbo.common.utils.NetUtils: boolean matchIpRange(java.lang.String,java.lang.String,int)>(r0, r1, i0);	return $z1
;block_num 2