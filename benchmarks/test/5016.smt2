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

(declare-sort var3873 0)
(declare-sort var3364 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun lastIndexOf/-1292097097 (String Int) Int)
(declare-fun var3364-init () var3364)
(declare-fun <init>/1014944800 (var3364 String Int String) void)
(declare-const null-String String)
(declare-const var621 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var621 null-String)))
(declare-const var2686 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2686 null-String)))
(declare-const var2844 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var2844 null-String)))
(define-const var3955 String null-String) ; Statement: r4 = null 
(define-const var3939 Int 0) ; Statement: i5 = 0 
(assert true)
(define-const var223 Int (lastIndexOf/-1292097097 var621 58)) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58) 
 ; Statement: if i0 < 0 goto r4 = r0 
(assert (< var223 0)) ; Cond: i0 < 0 
(define-const var3955!1 String var621) ; Statement: r4 = r0 
(assert true) ; Non Conditional
(define-const var1521 var3364 var3364-init) ; Statement: $r5 = new org.apache.dubbo.common.url.component.URLAddress 
(assert true)
;(assert (<init>/1014944800 var1521 var3955!1 var3939 var2686)) ; Statement: specialinvoke $r5.<org.apache.dubbo.common.url.component.URLAddress: void <init>(java.lang.String,int,java.lang.String)>(r4, i5, r1) 

(declare-const var1521!1 var3364)
(declare-const var3955!2 String)
(declare-const var3939!1 Int)
(declare-const var2686!1 String)
 ; Statement: return $r5 
(check-sat)
; {lastIndexOf/-1292097097=([java.lang.String, int], int), var3364-init=([], org.apache.dubbo.common.url.component.URLAddress), <init>/1014944800=([org.apache.dubbo.common.url.component.URLAddress, java.lang.String, int, java.lang.String], void)}
; {var621=r0, var3873=null_type, var2686=r1, var2844=r3, var3955=r4, var3939=i5, var223=i0, var3364=org.apache.dubbo.common.url.component.URLAddress, var1521=$r5}
; {r0=var621, null_type=var3873, r1=var2686, r3=var2844, r4=var3955, i5=var3939, i0=var223, org.apache.dubbo.common.url.component.URLAddress=var3364, $r5=var1521}
;seq <java.lang.String: int lastIndexOf(int)>
;cnt {"<java.lang.String: int lastIndexOf(int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	r4 = null;	i5 = 0;	i0 = virtualinvoke r0.<java.lang.String: int lastIndexOf(int)>(58);	if i0 < 0 goto r4 = r0;	r4 = r0;	$r5 = new org.apache.dubbo.common.url.component.URLAddress;	specialinvoke $r5.<org.apache.dubbo.common.url.component.URLAddress: void <init>(java.lang.String,int,java.lang.String)>(r4, i5, r1);	return $r5
;block_num 3