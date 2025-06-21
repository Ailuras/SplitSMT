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

(declare-sort var3867 0)
(declare-sort var1557 0)
(declare-sort var2609 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/1180346878 (var2609 String Int) void)
(declare-fun cast-from-var3867-to-var2609 (var3867) var2609)
(declare-fun code/1710828794 (var3867) Int)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun statusString/1710828794 (var3867) String)
(declare-const null-var3867 var3867)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1190 var3867) ; Statement: r0 := @this: org.apache.dubbo.remoting.http12.HttpStatus 
(assert (not (= var1190 null-var3867)))
(declare-const var2038 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2038 null-String)))
(declare-const var2256 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2256 null-Int)))
(declare-const var0 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var0 null-Int)))
(assert true)
;(assert (<init>/1180346878 (cast-from-var3867-to-var2609 var1190) var2038 var2256)) ; Statement: specialinvoke r0.<java.lang.Enum: void <init>(java.lang.String,int)>(r1, i0) 

(declare-const var1190!1 var3867)
(declare-const var2038!1 String)
(declare-const var2256!1 Int)
(declare-const var1190!2 var3867)
(assert (not (= var1190!2 null-var3867)))
(assert (= (code/1710828794 var1190!2) var0)) ; Statement: r0.<org.apache.dubbo.remoting.http12.HttpStatus: int code> = i1 
(define-const var2465 String (String_valueOf/1240665136 var0)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i1) 
(declare-const var1190!3 var3867)
(assert (not (= var1190!3 null-var3867)))
(assert (= (statusString/1710828794 var1190!3) var2465)) ; Statement: r0.<org.apache.dubbo.remoting.http12.HttpStatus: java.lang.String statusString> = $r2 
 ; Statement: return 
(check-sat)
; {<init>/1180346878=([java.lang.Enum, java.lang.String, int], void), cast-from-var3867-to-var2609=([org.apache.dubbo.remoting.http12.HttpStatus], java.lang.Enum), code/1710828794=([org.apache.dubbo.remoting.http12.HttpStatus], int), String_valueOf/1240665136=([int], java.lang.String), statusString/1710828794=([org.apache.dubbo.remoting.http12.HttpStatus], java.lang.String)}
; {var3867=org.apache.dubbo.remoting.http12.HttpStatus, var1190=r0, var2038=r1, var1557=null_type, var2256=i0, var0=i1, var2609=java.lang.Enum, var2465=$r2}
; {org.apache.dubbo.remoting.http12.HttpStatus=var3867, r0=var1190, r1=var2038, null_type=var1557, i0=var2256, i1=var0, java.lang.Enum=var2609, $r2=var2465}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.http12.HttpStatus;	r1 := @parameter0: java.lang.String;	i0 := @parameter1: int;	i1 := @parameter2: int;	specialinvoke r0.<java.lang.Enum: void <init>(java.lang.String,int)>(r1, i0);	r0.<org.apache.dubbo.remoting.http12.HttpStatus: int code> = i1;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(i1);	r0.<org.apache.dubbo.remoting.http12.HttpStatus: java.lang.String statusString> = $r2;	return
;block_num 1