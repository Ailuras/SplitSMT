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

(declare-sort var1422 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(declare-fun <init>/-253222812 (String (Array Int Int) Int Int) void)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var1301 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1301 null-String)))
(declare-const var2847 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var2847 null-Int)))
(declare-const var1273 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var1273 null-Int)))
(declare-const var871 Bool) ; Statement: z0 := @parameter3: boolean 
(assert (not (= var871 null-Bool)))
(declare-const var2278 (Array Int Int)) ; Statement: r3 := @parameter4: byte[] 
(assert (not (= var2278 null-__Array__Int__Int__)))
(declare-const var3546 (Array Int Int)) ; Statement: r1 := @parameter5: char[] 
(assert (not (= var3546 null-__Array__Int__Int__)))
(declare-const var507 Int) ; Statement: i10 := @parameter6: int 
(assert (not (= var507 null-Int)))
(define-const var1239 Int var2847) ; Statement: i11 = i0 
(assert true) ; Non Conditional
 ; Statement: if i11 >= i1 goto $r13 = new java.lang.String 
(assert (>= var1239 var1273)) ; Cond: i11 >= i1 
(define-const var886 String String-init) ; Statement: $r13 = new java.lang.String 
(assert true)
;(assert (<init>/-253222812 var886 var3546 0 var507)) ; Statement: specialinvoke $r13.<java.lang.String: void <init>(char[],int,int)>(r1, 0, i10) 

(declare-const var886!1 String)
(declare-const var3546!1 (Array Int Int))
(declare-const var1133 Int)
(declare-const var507!1 Int)
 ; Statement: return $r13 
(check-sat)
; {String-init=([], java.lang.String), <init>/-253222812=([java.lang.String, char[], int, int], void)}
; {var1301=r2, var1422=null_type, var2847=i0, var1273=i1, var871=z0, var2278=r3, var3546=r1, var507=i10, var1239=i11, var886=$r13, var1133=0}
; {r2=var1301, null_type=var1422, i0=var2847, i1=var1273, z0=var871, r3=var2278, r1=var3546, i10=var507, i11=var1239, $r13=var886, 0=var1133}
;seq <java.lang.String: void <init>(char[],int,int)>
;cnt {"<java.lang.String: void <init>(char[],int,int)>": 1}
;stmts r2 := @parameter0: java.lang.String;	i0 := @parameter1: int;	i1 := @parameter2: int;	z0 := @parameter3: boolean;	r3 := @parameter4: byte[];	r1 := @parameter5: char[];	i10 := @parameter6: int;	i11 = i0;	if i11 >= i1 goto $r13 = new java.lang.String;	$r13 = new java.lang.String;	specialinvoke $r13.<java.lang.String: void <init>(char[],int,int)>(r1, 0, i10);	return $r13
;block_num 3