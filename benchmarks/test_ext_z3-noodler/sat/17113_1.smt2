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

(declare-sort var2968 0)
(declare-sort var1640 0)
(declare-sort var3185 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1180346878 (var3185 String Int) void)
(declare-fun cast-from-var2968-to-var3185 (var2968) var3185)
(declare-fun String_toString/-1426662429 (String) String)
(declare-fun name/-1381360461 (var2968) String)
(declare-fun key/-1381360461 (var2968) String)
(declare-const null-var2968 var2968)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2805 var2968) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.HttpHeaderNames 
(assert (not (= var2805 null-var2968)))
(declare-const var464 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var464 null-String)))
(declare-const var706 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var706 null-Int)))
(declare-const var3835 String) ; Statement: r2 := @parameter2: java.lang.CharSequence 
(assert (not (= var3835 null-String)))
(assert true)
;(assert (<init>/1180346878 (cast-from-var2968-to-var3185 var2805) var464 var706)) ; Statement: specialinvoke r0.<java.lang.Enum: void <init>(java.lang.String,int)>(r1, i0) 

(declare-const var2805!1 var2968)
(declare-const var464!1 String)
(declare-const var706!1 Int)
(define-const var3510 String (String_toString/-1426662429 var3835)) ; Statement: $r3 = interfaceinvoke r2.<java.lang.CharSequence: java.lang.String toString()>() 
(declare-const var2805!2 var2968)
(assert (not (= var2805!2 null-var2968)))
(assert (= (name/-1381360461 var2805!2) var3510)) ; Statement: r0.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.String name> = $r3 
(declare-const var2805!3 var2968)
(assert (not (= var2805!3 null-var2968)))
(assert (= (key/-1381360461 var2805!3) var3835)) ; Statement: r0.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.CharSequence key> = r2 
 ; Statement: return 
(check-sat)
; {<init>/1180346878=([java.lang.Enum, java.lang.String, int], void), cast-from-var2968-to-var3185=([org.apache.dubbo.remoting.http12.HttpHeaderNames], java.lang.Enum), String_toString/-1426662429=([java.lang.CharSequence], java.lang.String), name/-1381360461=([org.apache.dubbo.remoting.http12.HttpHeaderNames], java.lang.String), key/-1381360461=([org.apache.dubbo.remoting.http12.HttpHeaderNames], java.lang.CharSequence)}
; {var2968=org.apache.dubbo.remoting.http12.HttpHeaderNames, var2805=r0, var464=r1, var1640=null_type, var706=i0, var3835=r2, var3185=java.lang.Enum, var3510=$r3}
; {org.apache.dubbo.remoting.http12.HttpHeaderNames=var2968, r0=var2805, r1=var464, null_type=var1640, i0=var706, r2=var3835, java.lang.Enum=var3185, $r3=var3510}
;seq <java.lang.CharSequence: java.lang.String toString()>
;cnt {"<java.lang.CharSequence: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.HttpHeaderNames;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	r2 := @parameter2: java.lang.CharSequence;	specialinvoke r0.<java.lang.Enum: void <init>(java.lang.String,int)>(r1, i0);	$r3 = interfaceinvoke r2.<java.lang.CharSequence: java.lang.String toString()>();	r0.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.String name> = $r3;	r0.<org.apache.dubbo.remoting.http12.HttpHeaderNames: java.lang.CharSequence key> = r2;	return
;block_num 1